package com.project.market.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.project.market.domain.ReviewpageDto;


public interface ReviewPageMapper {

	int AddreviewPage(ReviewpageDto dto);

	void insertFile(@Param("boardId")int string, @Param("fileName")String fileName,@Param("mod") String mod);

	ReviewpageDto getreview(int id);

	List<String> getreviewFile(int id);

	void deleteImg(@Param("id")int id,@Param("fileName") String fileName);

	void updatareview(ReviewpageDto dto);
	
	

}
