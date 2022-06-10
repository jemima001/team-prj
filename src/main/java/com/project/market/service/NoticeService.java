package com.project.market.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.market.domain.NoticeDto;
import com.project.market.mapper.NoticeMapper;

@Service
public class NoticeService {
	
	@Autowired
	private NoticeMapper mapper;

	public List<NoticeDto> getNoticeList(int page, int rowPerPage) {
		int from = (page-1) * rowPerPage;
		return mapper.selectNotice(from, rowPerPage);
	}

	public int countCustomers() {
		// TODO Auto-generated method stub
		return mapper.countBoard();
	}

	public boolean addNotice(NoticeDto notice) {
		// TODO Auto-generated method stub
		int cnt = mapper.insertNotice(notice);
		
		return cnt == 1;
	}

	public NoticeDto getNoticeById(int id) {
		NoticeDto board = mapper.selectNoticeById(id);
		return board;
	}
	
	
}
