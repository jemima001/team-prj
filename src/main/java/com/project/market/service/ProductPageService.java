package com.project.market.service;

import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.project.market.domain.ProductDto;
import com.project.market.domain.ProductPageDto;
import com.project.market.mapper.ProductPageMapper;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
public class ProductPageService {
	
	@Autowired
	ProductPageMapper mapper;
	
	// ------ 파일 업로드를 위한 부분----------
	@Value("${aws.s3.bucketName}") 
	private String bucketName;
	
	private S3Client s3;

	// 파일 업로드 세팅
	@PostConstruct
	public void init() {
		Region region = Region.AP_NORTHEAST_2;
		
		this.s3 = S3Client.builder().region(region).build();
	}
	// 파일업 메소드  종료
	@PreDestroy
	public void destroy() {
		this.s3.close();
	}
	
	private void addFiles(int string, MultipartFile[] files) {
		if (files != null) {
			for (MultipartFile file : files) {
				if (file.getSize() >0) {
					
					mapper.insertFile(string, file.getOriginalFilename());
					
					saveFileAwsS3(string,file);
				}
			}
		}
	}
	
	public void saveFileAwsS3(int string, MultipartFile file) {
		String key ="project/" + string + "/" + file.getOriginalFilename();
	
		PutObjectRequest putObjectRequest = PutObjectRequest.builder().acl(ObjectCannedACL.PUBLIC_READ)
											.bucket(bucketName).key(key)
											.build();
		
		RequestBody requestBody;
		
		try {
			requestBody = RequestBody.fromInputStream(file.getInputStream(), file.getSize());
			s3.putObject(putObjectRequest, requestBody);
		} catch (IOException e) {
			e.printStackTrace();
			
			throw new RuntimeException();
		}
	}
	//---------
	public void AddProductPage(ProductPageDto dto , int productId, MultipartFile[] files) {
		String BoardTitle = dto.getBoardTitle();
		String BoardBody = dto.getBoardBody();
		dto.setProductId(productId);
		int ok = mapper.AddPage(dto);
		System.out.println("글 등록 직후 boardId 확인 :"+ dto.getId());
		//int getBoaradId = mapper.getboardId();
		// 파일 추가 부분 
		addFiles(dto.getId(), files);
	}
	@Transactional
	public int addProduct(ProductDto dto) {
		ProductDto NewProductDto = new ProductDto();
		int ok = mapper.Addproduct(dto);
		int productId =  mapper.getproductId(dto);
		NewProductDto.setProductId(productId);
		int NewProductCode0 = dto.getProduct_middle_class();
		int	NewProductCode1 = dto.getProduct_low_class();
		
		mapper.Addcategory(NewProductCode0, NewProductCode1 , productId);
		return mapper.getproductId(NewProductDto);
	}

	public List<ProductDto> getcategory() {
		// TODO Auto-generated method stub
		return mapper.getcategory();
	}

	public List<ProductDto> getcategory_low(ProductDto dto) {
		// TODO Auto-generated method stub
		return mapper.getcategory_low(dto);
	}
	public ProductPageDto getProductBoard(int boardid) {
		// TODO Auto-generated method stub
		return mapper.getproductBoard(boardid);
	}
	public ProductDto getproduct(int productId) {
		// TODO Auto-generated method stub
		return mapper.getproduct(productId);
	}
	public List<ProductPageDto> getboardlist() {
		// TODO Auto-generated method stub
		return mapper.getBoardlist();
	}
	public boolean deleteBoard(ProductPageDto dto) {
		int ok = mapper.deleteBoard(dto);
		
		return ok ==1;
	}
	public List<String> getfileList(int id) {
		List<String> fileList = mapper.getfileList(id);
		System.out.println("fileList in 서비스:"+fileList);
		return fileList;
	}
	

	

}
