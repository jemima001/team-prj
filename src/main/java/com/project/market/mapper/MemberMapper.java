package com.project.market.mapper;

import com.project.market.domain.MemberDto;

public interface MemberMapper {

	int insertMember(MemberDto member);

	int countMemberId(String id);

	int countMemberEmail(String email);

	int countMemberNickName(String nickName);
}






