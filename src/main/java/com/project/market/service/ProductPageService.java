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
import com.project.market.domain.ReviewpageDto;
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

	private void addFiles(int string, MultipartFile[] files, String mod) {
		System.out.println("리뷰페이지 사진 저장0");
		if (files != null && mod.equals("productpage")) {
			for (MultipartFile file : files) {
				if (file.getSize() > 0) {

					mapper.insertFile(string, file.getOriginalFilename(), mod);

					saveFileAwsS3(string, file, "productpage");
				}
			}
		} else if (files != null && mod.equals("reviewpage")) {
			System.out.println("리뷰페이지 사진 저장1");
			for (MultipartFile file : files) {
				if (file.getSize() > 0) {

					mapper.insertFile(string, file.getOriginalFilename(), mod);

					saveFileAwsS3(string, file, "reviewpage");
				}
			}
		}
	}

	public void saveFileAwsS3(int string, MultipartFile file, String mod) {

		if (mod.equals("productpage")) {

			String key = "project/" + string + "/" + file.getOriginalFilename();

			PutObjectRequest putObjectRequest = PutObjectRequest.builder().acl(ObjectCannedACL.PUBLIC_READ)
					.bucket(bucketName).key(key).build();

			RequestBody requestBody;

			try {
				requestBody = RequestBody.fromInputStream(file.getInputStream(), file.getSize());
				s3.putObject(putObjectRequest, requestBody);
			} catch (IOException e) {
				e.printStackTrace();

				throw new RuntimeException();
			}
		} else if (mod.equals("reviewpage")) {
				System.out.println("리뷰페이지 사진 저장2");
			String key = "project/reviewpage/" + string + "/" + file.getOriginalFilename();

			PutObjectRequest putObjectRequest = PutObjectRequest.builder().acl(ObjectCannedACL.PUBLIC_READ)
					.bucket(bucketName).key(key).build();

			RequestBody requestBody;

			try {
				requestBody = RequestBody.fromInputStream(file.getInputStream(), file.getSize());
				s3.putObject(putObjectRequest, requestBody);
			} catch (IOException e) {
				e.printStackTrace();

				throw new RuntimeException();
			}
		}
	}

	//---------
	public boolean AddProductPage(ProductPageDto dto, int productId, MultipartFile[] files) {
		String BoardTitle = dto.getBoardTitle();
		String BoardBody = dto.getBoardBody();
		dto.setProductId(productId);
		int ok = mapper.AddPage(dto);
		System.out.println("글 등록 직후 boardId 확인 :" + dto.getId());
		//int getBoaradId = mapper.getboardId();
		// 파일 추가 부분 
		addFiles(dto.getId(), files, "productpage");
		return ok == 1;
	}

	@Transactional
	public int addProduct(ProductDto dto) {
		System.out.println("테스트1!");
		ProductDto NewProductDto = new ProductDto();
		int ok = mapper.Addproduct(dto);
		System.out.println(ok);
		System.out.println(dto);
		
		int productId = mapper.getproductId(dto);
		System.out.println(productId);
		NewProductDto.setProductId(productId);
		int NewProductCode0 = dto.getProduct_Middle_Class();
		int NewProductCode1 = dto.getProduct_Low_Class();
		System.out.println("NewProductCode0:"+NewProductCode0);
		System.out.println("NewProductCode1 :"+NewProductCode1);
		System.out.println("productId" +productId);

		mapper.Addcategory(NewProductCode0, 1, productId); 
		System.out.println("테스트2");
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

	public List<ProductPageDto> getboardlist(String cat, String search, PaginationDto paginationDto) {

		int pageToStart = (paginationDto.getPage() - 1) * 15;
		int onePageAllBoardNum = paginationDto.getOnePageAllBoardNum();

		return mapper.getBoardlist(cat, "%" + search + "%", pageToStart, onePageAllBoardNum);
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
	@Transactional
	public boolean deleteBoard(ProductPageDto dto, ArrayList<String> deleteImg) {
		System.out.println(dto.getFileList());
		
		List<String> fileList = mapper.getBoardFile(dto);
		
		for(String file :  fileList) {
			System.out.println("file : "+file);
			System.out.println("삭제 테스트");
			deleterFromAwsS3(dto.getId(),file ,"productPage" );
		}
		int ok = mapper.deleteBoard(dto);

		return ok == 1;
	}

	public List<String> getfileList(int id) {
		List<String> fileList = mapper.getfileList(id);
		//	System.out.println("fileList in 서비스:"+fileList);
		return fileList;
	}

	public boolean upDateProduct(ProductDto dto) {
		// TODO Auto-generated method stub
		int cun = mapper.updateProduct(dto);
		return cun == 1;
	}

	@Transactional
	public boolean upDatepage(ProductPageDto pageDto, MultipartFile[] files, ArrayList<String> deleteImg) {
		System.out.println("getId 페이지 아이디 확인 :" + pageDto.getId());

		if (deleteImg != null) {
			for (String fileName : deleteImg) {
				deleterFromAwsS3(pageDto.getId(), fileName, "productPage" );
				mapper.deleteImg(pageDto.getId(), fileName);
			}
		}

		if (files != null) {

			addFiles(pageDto.getId(), files, "productpage");

		}

		int cun = mapper.updataPage(pageDto);
		return cun == 1;
	}

	private void deleterFromAwsS3(int id, String fileName, String mod) {
		String key = null;
		
		if(mod.equals("productPage")) {
			System.out.println("삭제 테스트 !!!");
			System.out.println("id :"+id);
			System.out.println("fileName :"+fileName);
		 key = "project/" + id + "/" + fileName;
		} else if(mod.equals("reviewpage")) {
		 key = "project/reviewpage/" + id + "/" + fileName;
		}
		DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder().bucket(bucketName).key(key).build();
		s3.deleteObject(deleteObjectRequest);
	}

	public List<ProductDto> Productlist() {
		// TODO Auto-generated method stub
		return mapper.getprodutlist();
	}

	@Transactional
	public boolean deleteProduct(ProductDto dto) {
		
		int okDeleteCategory = mapper.deleteCategory(dto);
		int okDeleteCart = mapper.deleteCart(dto);
		int okDeleteBoard = mapper.deleteBoardfordeleteProduct(dto);
		int okDeleteProduct = mapper.DeleteProduct(dto);

		System.out.println("okDeleteCategory:" + okDeleteCategory);
		System.out.println("okDeleteProduct:" + okDeleteProduct);

		return okDeleteProduct == 1;
	}

	public boolean modifyProduct(ProductDto dto) {
		int ok = mapper.modifyProduct(dto);
		return ok == 1;
	}

	public List<String> getFileForList() {
		// TODO Auto-generated method stub
		return mapper.getFileForList();
	}

	public void addCart(ProductDto dto, Principal principal) {
		// TODO Auto-generated method stub
		String memberId = principal.getName();
		System.out.println("서비스" + dto);
		int bookCount = dto.getPurchase();
		int productId = dto.getProductId();
		System.out.println("구매 갯수 서비스에서" + bookCount);
		System.out.println("제품 아이디 서비스에서" + productId);
		System.out.println("맴버 아이디 서비스 에서" + memberId);
		mapper.addCart(memberId, bookCount, productId);

	}

	public PaginationDto getCountBoard(String cat, int setOnePageAllBoardNum) {
		PaginationDto paginationDto = mapper.getAllBoardNum(cat);
		int allPageNum = paginationDto.getAllBoard();
		/*System.out.println("allPageNum:"+allPageNum);
		System.out.println("setOnePageAllBoardNum :"+setOnePageAllBoardNum);*/
		paginationDto.setOnePageAllBoardNum(setOnePageAllBoardNum);
		paginationDto.setEndPage((allPageNum / setOnePageAllBoardNum) + 1);
		/*System.out.println("(allPageNum/setOnePageAllBoardNum)+1 :"+(allPageNum/setOnePageAllBoardNum)+1);
		System.out.println("(allPageNum/setOnePageAllBoardNum): "+(allPageNum/setOnePageAllBoardNum));*/
		if (paginationDto.getEndPage() == 0) {
			paginationDto.setEndPage(1);

		}

		System.out.println("서비스에서 나가는 페이지네비게이터 Dto:" + paginationDto);
		paginationDto.setCat(cat);
		paginationDto.setStartPage(1);

		return paginationDto;
	}

	public int getcategoryone(ProductDto dto) {
		System.out.println("서비스");
		int cat0 = mapper.getcat0(dto);
		System.out.println("cat0= "+ cat0);
		return cat0;
	}

	public String getCategoryName(int category) {
		String categoryName = mapper.getCategoryName(category);
		return categoryName;
	}

	public boolean searchProductName(String name) {
		int ok = mapper.searchProductName(name);
		System.out.println("같은 상품 이름 갯수"+ok);
		return ok>0;
	}

	public boolean addReviewPage(ReviewpageDto dto, MultipartFile[] files) {
		System.out.println("리뷰페이지 서비스 dto :"+dto);
		System.out.println("리뷰페이지 서비스 files :"+files);
		int ok = mapper.AddreviewPage(dto);
		
		addFiles(dto.getId(), files, "reviewpage");
		return false;
	}

	public List<ReviewpageDto> getReviewList(int id) {
		
		return mapper.getReviewList(id);
	}
@Transactional
	public boolean deleteReview(ReviewpageDto dto) {
		int id = dto.getId();
		System.out.println("deleteReview in getId(); :"+dto.getId());
		List<String> replyFileList = mapper.replyViewFileList(id);
		for(String file : replyFileList) {
			
		deleterFromAwsS3(id, file, "reviewpage");
		}
		
		int ok =mapper.deleteReview(dto.getId());
		return ok ==1;
	} 

}
