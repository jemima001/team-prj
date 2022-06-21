package com.project.market.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.market.domain.AnswerDto;

public interface AnswerMapper {

	void insertFile(@Param("queryId") int queryId, @Param("fileName") String fileName);

	int insertQuery(AnswerDto answer);

	AnswerDto selectAnwserById(int id);

	List<String> selectFileNameByAnswer(int queryId);

	void deleteFileByAnswerIdAndFileName(@Param("queryId") int id,
			@Param("fileName") String fileName);

	int updateAnswer(AnswerDto dto);

	int deleteAnswer(int queryId);

	void deleteFileByQueryId(int id);

	void deleteByAnswerId(int id);

	AnswerDto selectAnserByQueryId(int id);

}
