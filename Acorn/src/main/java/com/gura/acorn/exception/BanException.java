package com.gura.acorn.exception;
/*
 * 	예외 클래스를 만드는 방법
 * 
 * 	1. RuntimeException 클래스를 상속 받아서 만든다.
 * 	2. String type 을 전달받는 생성자를 정의한 다음 생성자에 전달되는 문자열을 부모 생성자에
 * 	   전달하는 코드를 작성한다.
 *  - 이 클래스로 생성된 객체는 getMessage() 라는 메소드를 가지고 있는데
 *    해당 메소드는 생성자에 전달받았던 예외 메시지를 리턴해준다.
 *    
 *  ex)
 *  NotDeleteException nde = new NotDeleteException("oh! no");
 *  String msg = nde.getMessage(); // "oh! no"
 *  
 *  - 어디에선가 이 예외를 발생시키고 싶으면 throw 예약어를 활용하면된다.
 *  
 *  ex)
 *  throw new NotDeleteException("남의 파일 지우기 없기");
 */
public class BanException extends RuntimeException{
	
	// 생성자
	public BanException(String message) {
		super(message);
	}
}
