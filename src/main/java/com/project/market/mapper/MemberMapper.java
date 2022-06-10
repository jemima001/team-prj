package com.project.market.mapper;

import org.apache.ibatis.annotations.Param;

import com.project.market.domain.MemberDto;

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
}






