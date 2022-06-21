package com.project.market.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.project.market.domain.QueryDto;

public interface QueryMapper {

	int insertQuery(QueryDto query);

	void insertFile(@Param("queryId") int queryId, @Param("fileName") String fileName);

	List<QueryDto> selectQuery(@Param("from") int from, 
							   @Param("row") int row);

	int countQuery();

	QueryDto selectQueryById(int id);

	List<String> selectFileNameByQuery(int queryId);

	void deleteFileByQueryIdAndFileName(@Param("queryId") int id,
			@Param("fileName") String fileName);

	int updateQuery(QueryDto dto);

	int deleteQuery(int id);

	void deleteFileByQueryId(int id);

}
