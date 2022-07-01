package com.project.market.service;

import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.project.market.domain.AddressDto;
import com.project.market.domain.MemberDto;
import com.project.market.domain.OrderDto;
import com.project.market.domain.ProductDto;
import com.project.market.domain.ReviewpageDto;
import com.project.market.mapper.MemberMapper;

import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;

@Service
public class MemberService {

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
	
	@Autowired
	private MemberMapper mapper;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	public boolean addMember(MemberDto member) {

		// 평문암호를 암호화(encoding)
		String encodedPassword = passwordEncoder.encode(member.getPassword());

		// 암호화된 암호를 다시 세팅
		member.setPassword(encodedPassword);

		// insert member
		int cnt1 = mapper.insertMember(member);

		// insert auth
		int cnt2 = mapper.insertAuth(member.getId(), "ROLE_USER");

		return cnt1 == 1 && cnt2 == 1;

	}

	public MemberDto getMemberById(String id) {
		// TODO Auto-generated method stub
		return mapper.selectMemberById(id);
	}

	@Transactional
	public boolean removeMember(MemberDto dto) {
		MemberDto member = mapper.selectMemberById(dto.getId());

		String rawPW = dto.getPassword();
		String encodedPW = member.getPassword();

		if (passwordEncoder.matches(rawPW, encodedPW)) {
			// queryId 받아오기
			List<Integer> queryIdList = mapper.selectAllQueryId(dto.getId());
			
			// 리뷰 사진 이름 아이디 받아오기
			List<ReviewpageDto> reviewList = mapper.selectAllreview(dto.getId());
			
			// 문의 파일 삭제
			for(Integer queryId : queryIdList) {
				mapper.removeQueryFile(queryId);
			}
			
			// 문의 응답 파일 삭제
			for(Integer queryId : queryIdList) {
				mapper.removeAnswerFile(queryId);
			}
			
			// 문의 응답 삭제
			for(Integer queryId : queryIdList) {
				mapper.removeAnswers(queryId);
			}
			// 리뷰 사진 삭제
			for(ReviewpageDto list : reviewList) {
				deleteReviewImg(list.getReviewId(), list.getFileName());
			}
			
			// 리뷰 삭제
			mapper.removereview(dto.getId());
			
			// 문의 삭제
			mapper.removeQuestions(dto.getId());
			
			// 주문목록 삭제
			mapper.removeOrders(dto.getId());
			
			// 장바구니 삭제
			mapper.removeCart(dto.getId());
			
			// 주소 삭제
			mapper.removeAddressById(dto.getId());
			
			// 권한테이블 삭제
			mapper.deleteAuthById(dto.getId());

			// 멤버테이블 삭제
			int cnt = mapper.deleteMemberById(dto.getId());

			return cnt == 1;
		}

		return false;
	}
	
	private void deleteReviewImg(int id, String fileName) {
		String key = null;
		
		 key = "project/reviewpage/" + id + "/" + fileName;
		
		DeleteObjectRequest deleteObjectRequest = DeleteObjectRequest.builder().bucket(bucketName).key(key).build();
		s3.deleteObject(deleteObjectRequest);
	}

	public boolean modifyMember(MemberDto dto, String oldPassword) {
		// db에서 member 읽어서
		MemberDto oldMember = mapper.selectMemberById(dto.getId());

		String encodedPW = oldMember.getPassword();

		// 기존password가 일치할 때만 계속 진행
		if (passwordEncoder.matches(oldPassword, encodedPW)) {

			// 암호 인코딩
			dto.setPassword(passwordEncoder.encode(dto.getPassword()));

			return mapper.updateMember(dto) == 1;
		}

		return false;
	}

	public boolean hasMemberId(String id) {
		return mapper.countMemberId(id) > 0;
	}

	public boolean hasMemberEmail(String email) {
		return mapper.countMemberEmail(email) > 0;
	}

	public boolean hasMemberNickName(String nickName) {
		return mapper.countMemberNickName(nickName) > 0;
	}

	public boolean setAddress(MemberDto dto) {

		return mapper.updateAddress(dto.getId(), dto) == 1;

	}

	public void initPassword(String id) {

		String pw = passwordEncoder.encode(id);
		mapper.updatePasswordById(id, pw);
	}

	public List<MemberDto> listMember() {

		return mapper.selectAllMember();
	}
	
	public List<ProductDto> Productlist() {
		return mapper.getProductlist();
	}

	public List<AddressDto> listAddress(String id) {
		
		return mapper.selectAllAddress(id);
	}

	public void updateOneAddress(String id, String address) {
		mapper.updateOneAddress(id, address);
	}

	public void removeAddress(String address) {
		mapper.removeAddress(address);
	}

	public boolean hasAddress(String memberId, String address) {
		return mapper.countAddress(memberId, address) > 0;
	}

	public List<OrderDto> listUserOrder(String id) {
		return mapper.selectUserOrder(id);
	}

	public List<OrderDto> listAllOrder() {
		return mapper.selectAllOrder();
	}

	public MemberDto searchId(String email) {
		
		return mapper.findId(email);
	}

	public void approveOrder(int orderId) {
		mapper.orderApprove(orderId);
	}

	public boolean hasMemberEmailById(String id, String email) {
		return mapper.countEmailById(id, email) > 0;
	}

	public void countStock(int bookCount, String productName) {
		mapper.countStockProduct(bookCount, productName);
	}

	public int getStock(String productName) {
		return mapper.getStockByProduct(productName);
	}

	public List<OrderDto> listPageOrder(int limitNumber) {
		return mapper.selectPageOrder(limitNumber);
	}

	public List<OrderDto> listUserPageOrder(String id, int limitNumber) {
		return mapper.selectUserPageOrder(id, limitNumber);
	}

}