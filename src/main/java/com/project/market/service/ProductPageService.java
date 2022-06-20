package com.project.market.service;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.multipart.MultipartFile;

import com.project.market.domain.PaginationDto;
import com.project.market.domain.ProductDto;
import com.project.market.domain.ProductPageDto;
import com.project.market.mapper.ProductPageMapper;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
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
	public boolean AddProductPage(ProductPageDto dto , int productId, MultipartFile[] files) {
		String BoardTitle = dto.getBoardTitle();
		String BoardBody = dto.getBoardBody();
		dto.setProductId(productId);
		int ok = mapper.AddPage(dto);
		System.out.println("글 등록 직후 boardId 확인 :"+ dto.getId());
		//int getBoaradId = mapper.getboardId();
		// 파일 추가 부분 
		addFiles(dto.getId(), files);
		return ok ==1;
	}
	@Transactional
	public int addProduct(ProductDto dto) {
		ProductDto NewProductDto = new ProductDto();
		int ok = mapper.Addproduct(dto);
		System.out.println(ok);
		System.out.println(dto);
		int productId =  mapper.getproductId(dto);
		System.out.println(productId);
		NewProductDto.setProductId(productId);
		int NewProductCode0 = dto.getProduct_Middle_Class();
		int	NewProductCode1 = dto.getProduct_Low_Class();
		
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
	public List<ProductPageDto> getboardlist(String cat, String search, PaginationDto paginationDto ) { 
		
		
		int pageToStart = (paginationDto.getPage()-1)*15 ;
		int onePageAllBoardNum = paginationDto.getOnePageAllBoardNum();
		
		return mapper.getBoardlist(cat, 
								  "%" + search +"%", 
								  pageToStart, 
								  onePageAllBoardNum
								  );
	}
	
	// 페이지 값 정의 하는 메소드
	/*private PaginationDto pageWork(PaginationDto paginationDto, int onePageShowNum) {
		paginationDto.setOnePageAllBoardNum(onePageShowNum); // 한 페이지 총 보여주는 게시물 갯수
		paginationDto.setStartPage(1);           // 페이지 네비게이터 시작수
		paginationDto.setAllPageNum(mapper.getAllBoardNum());
		int nowPage = paginationDto.getPage();
		int pageToStart = (nowPage-1)*15 ;
		int allBoardnum = mapper.getAllBoardNum();
		int endnum = allBoardnum / paginationDto.getOnePageAllBoardNum();
		paginationDto.setPageToStart(pageToStart);
		paginationDto.setEndPage(endnum);
		System.out.println(paginationDto);
		
		
		return paginationDto;
		
	}*/
	public boolean deleteBoard(ProductPageDto dto) {
		int ok = mapper.deleteBoard(dto);
		
		return ok ==1;
	}
	public List<String> getfileList(int id) {
		List<String> fileList = mapper.getfileList(id);
	//	System.out.println("fileList in 서비스:"+fileList);
		return fileList;
	}
	public boolean upDateProduct(ProductDto dto) {
		// TODO Auto-generated method stub
		 int cun = mapper.updateProduct(dto);
		return cun==1; 
	}
	@Transactional
	public boolean upDatepage(ProductPageDto pageDto, MultipartFile[] files, ArrayList<String> deleteImg) {
		System.out.println("getId 페이지 아이디 확인 :"+pageDto.getId());
		
		if(deleteImg != null) {
			for (String fileName : deleteImg ) {
				deleterFromAwsS3(pageDto.getId(), fileName);
				mapper.deleteImg(pageDto.getId(), fileName);
			}
		}
		
		
		if(files != null) {
			
		addFiles(pageDto.getId(), files);
		
		}
		
		int cun = mapper.updataPage(pageDto);
		return cun==1;
	}
	private void deleterFromAwsS3(int id, String fileName) {
		String key = "board/" + id +"/"+ fileName;
		DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
				.bucket(bucketName)
				.key(key)
				.build();
		s3.deleteObject(deleteObjectRequest);
	}

	public List<ProductDto> Productlist() {
		// TODO Auto-generated method stub
		return mapper.getprodutlist();
	}
	@Transactional
	public boolean deleteProduct(ProductDto dto) {
		int okDeleteCategory= mapper.deleteCategory(dto);
		int okDeleteProduct = mapper.DeleteProduct(dto);
		
		System.out.println("okDeleteCategory:"+okDeleteCategory);
		System.out.println("okDeleteProduct:"+okDeleteProduct);
		
		return okDeleteProduct == 1;
	}
	public boolean modifyProduct(ProductDto dto) {
		int ok = mapper.modifyProduct(dto);
		return ok==1;
	}
	public List<String> getFileForList() {
		// TODO Auto-generated method stub
		return mapper.getFileForList();
	}
	public void addCart(ProductDto dto, Principal principal) {
		// TODO Auto-generated method stub
		String memberId = principal.getName();
		System.out.println("서비스"+dto);
		int bookCount = dto.getPurchase();
		int productId = dto.getProductId();
		System.out.println("구매 갯수 서비스에서"+bookCount);
		System.out.println("제품 아이디 서비스에서"+productId);
		System.out.println("맴버 아이디 서비스 에서"+memberId);
		mapper.addCart(memberId,bookCount,productId);
		
	}
	public PaginationDto getCountBoard(String cat, int setOnePageAllBoardNum) {
		PaginationDto paginationDto = mapper.getAllBoardNum(cat);
		int allPageNum = paginationDto.getAllBoard();
		/*System.out.println("allPageNum:"+allPageNum);
		System.out.println("setOnePageAllBoardNum :"+setOnePageAllBoardNum);*/
		paginationDto.setOnePageAllBoardNum(setOnePageAllBoardNum);
		paginationDto.setEndPage((allPageNum/setOnePageAllBoardNum)+1);
		/*System.out.println("(allPageNum/setOnePageAllBoardNum)+1 :"+(allPageNum/setOnePageAllBoardNum)+1);
		System.out.println("(allPageNum/setOnePageAllBoardNum): "+(allPageNum/setOnePageAllBoardNum));*/
		if(paginationDto.getEndPage()== 0) {
			paginationDto.setEndPage(1);
			
		}
		
		System.out.println("서비스에서 나가는 페이지네비게이터 Dto:"+paginationDto);
		paginationDto.setCat(cat);
		paginationDto.setStartPage(1);
		
		return  paginationDto;
	}
	

	

}
