package com.project.market.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.project.market.domain.AnswerDto;
import com.project.market.mapper.AnswerMapper;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
public class AnswerService {

	@Autowired
	private AnswerMapper mapper;
	
	private S3Client s3;
	
	@Value("${aws.s3.bucketName}")
	private String bucketName;
	
	@PostConstruct
	public void init() {
		Region region = Region.AP_NORTHEAST_2;
		this.s3 = S3Client.builder().region(region).build();
	}
	
	@PreDestroy
	public void destroy() {
		this.s3.close();
	}
	
	@Transactional
	public boolean insertQuery(AnswerDto answer, MultipartFile[] files) {
		// TODO Auto-generated method stub
		int cnt = mapper.insertQuery(answer);
		
		addFiles(answer.getQueryId(), files);
		
		return cnt == 1;
	}
	
	private void addFiles(int id, MultipartFile[] files) {
		// 파일 등록 
		if (files != null) {
			for (MultipartFile file : files) {
				if (file.getSize() > 0) {
					mapper.insertFile(id, file.getOriginalFilename());
					saveFileAwsS3(id, file); // s3에 업로드
				}
			}
		}
	}

	private void saveFileAwsS3(int id, MultipartFile file) {
		String key = "project/answer/" + id + "/" + file.getOriginalFilename();
		
		PutObjectRequest putObjectRequest = PutObjectRequest.builder()
				.acl(ObjectCannedACL.PUBLIC_READ)
				.bucket(bucketName)
				.key(key)
				.build();
		
		RequestBody requestBody;
		try {
			requestBody = RequestBody.fromInputStream(file.getInputStream(), file.getSize());
			s3.putObject(putObjectRequest, requestBody);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}

	public AnswerDto getAnswerById(int id) {
		AnswerDto answer = mapper.selectAnwserById(id);
		List<String> fileNames = mapper.selectFileNameByAnswer(answer.getQueryId());
		if(answer != null) {
			answer.setFileName(fileNames);
		}
		return answer;
	}

	@Transactional
	public boolean updateAnswer(AnswerDto dto, ArrayList<String> removeFileList, MultipartFile[] addFileList) {
		if (removeFileList != null) {
			for (String fileName : removeFileList) {
				deleteFromAwsS3(dto.getQueryId(), fileName);
				mapper.deleteFileByAnswerIdAndFileName(dto.getQueryId(), fileName);
			}
		}
		
		if (addFileList != null) {
			// File 테이블에 추가된 파일 insert
			// s3에 upload
			addFiles(dto.getQueryId(), addFileList);
		}
		
		// Query 테이블 update
		int cnt = mapper.updateAnswer(dto);
		
		return cnt == 1;
	}

	private void deleteFromAwsS3(int id, String fileName) {
		String key = "project/answer/" + id + "/" + fileName;
		
		DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder()
				.bucket(bucketName)
				.key(key)
				.build();
		
		s3.deleteObject(deleteObjectRequest);
	}

	public boolean deleteAnswer(int id) {
		List<String> fileList = mapper.selectFileNameByAnswer(id);
		
		removeFiles(id, fileList);
		
		// 댓글테이블 삭제
		
		return mapper.deleteAnswer(id) == 1;
	}

	private void removeFiles(int id, List<String> fileList) {
		// s3에서 지우기
				for (String fileName : fileList) {
					deleteFromAwsS3(id, fileName);
				}
				
				// 파일테이블 삭제
				mapper.deleteFileByQueryId(id);
	}

	public AnswerDto getAnswerByQueryId(int id) {
		AnswerDto answer = mapper.selectAnserByQueryId(id);
		List<String> fileNames = mapper.selectFileNameByAnswer(id);
		if(answer != null) {
			answer.setFileName(fileNames);
		}
		return answer;
	}
}
