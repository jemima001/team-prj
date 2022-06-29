package com.project.market.service;

import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.multipart.MultipartFile;

import com.project.market.domain.ReviewpageDto;
import com.project.market.mapper.ReviewPageMapper;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
public class ReviewpageService {
	
@Autowired
 ReviewPageMapper mapper;


//------ 파일 업로드를 위한 부분----------
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

	

	public boolean addReviewPage(ReviewpageDto dto, MultipartFile[] files) {
		System.out.println("리뷰페이지 서비스 dto :"+dto);
		System.out.println("리뷰페이지 서비스 files :"+files);
		int ok = mapper.AddreviewPage(dto);
		
		addFiles(dto.getId(), files, "reviewpage");
		return false;
	}

	public ReviewpageDto getReview(int id) {
		
		return mapper.getreview(id);
	}

	public List<String> getreviewFile(int id) {
		List <String> list = mapper.getreviewFile(id);
		return list;
	}

	public void deleteImg(int id, List<String> deleteimg) {
		
		for(String fileName : deleteimg) {
			
		deleterFromAwsS3(id, fileName, "reviewpage");
		mapper.deleteImg(id, fileName);
		}
		
		
	}

	public void upImg(ReviewpageDto dto, MultipartFile[] files) {
		addFiles(dto.getId(), files, "reviewpage");
		
		
	}

	public void updatareview(ReviewpageDto dto) {
		mapper.updatareview(dto);
		
	}

	
	
}
