package com.project.market.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class OrderDto {
	private String id;
	private String address;
	private LocalDateTime inserted;
}
