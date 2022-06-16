package com.project.market.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.market.domain.NoticeDto;

public interface NoticeMapper {

	List<NoticeDto> selectNotice(@Param("from") int from, 
							   @Param("row") int row);
	
	int countNotice();

	int insertNotice(NoticeDto notice);

	NoticeDto selectNoticeById(int id);

	int updateBoard(NoticeDto dto);

	int deleteNotice(int id);

}
