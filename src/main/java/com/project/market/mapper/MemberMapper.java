package com.project.market.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.market.domain.AddressDto;
import com.project.market.domain.MemberDto;
import com.project.market.domain.OrderDto;
import com.project.market.domain.ProductDto;

public interface MemberMapper {

	int insertMember(MemberDto member);

	int countMemberId(String id);

	int countMemberEmail(String email);

	int countMemberNickName(String nickName);

	MemberDto selectMemberById(String id);

	int insertAuth(@Param("id") String id, @Param("auth") String auth);

	int deleteAuthById(String id);

	int deleteMemberById(String id);

	int updateMember(MemberDto dto);

	int updateAddress(@Param("id") String id,@Param("member") MemberDto member);
	
	void updatePasswordById(@Param("id") String id, @Param("pw") String pw);

	List<MemberDto> selectAllMember();
	
	List<ProductDto> getProductlist();

	List<AddressDto> selectAllAddress(String id);

	int updateOneAddress(@Param("id") String id,@Param("address") String address);

	void removeAddress(String address);

	int countAddress(@Param("memberId")String memberId, @Param("address")String address);

	List<OrderDto> selectUserOrder(String id);

	List<OrderDto> selectAllOrder();

	MemberDto findId(String email);

	void orderApprove(int orderId);

	void removeAddressById(String id);

	void removeCart(String id);

	void removeOrders(String id);

	void removeQuestions(String id);

	List<Integer> selectAllQueryId(String id);

	void removeAnswers(Integer queryId);

	void removeAnswerFile(Integer queryId);

	void removeQueryFile(Integer queryId);

}






