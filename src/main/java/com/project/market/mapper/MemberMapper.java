package com.project.market.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.market.domain.MemberDto;

public interface MemberMapper {

	int insertMember(MemberDto member);

}






