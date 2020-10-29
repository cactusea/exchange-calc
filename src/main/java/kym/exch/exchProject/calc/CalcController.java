package kym.exch.exchProject.calc;

import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import kym.exch.exchProject.calc.service.CalcService;

@Controller
@RequestMapping(value="/Calc")
public class CalcController {
	
	@Autowired
	private CalcService calcService;
	
	@RequestMapping(value="/ExchageRate.do")
	public ModelAndView calcRate(@RequestParam Map<String, Object> params) {
		ModelAndView mav = new ModelAndView();
		
		String remAmount = params.get("remAmount").toString();
		String result = calcService.calcRate(params);
		
		String msg = "";
		msg = "수취 금액은 ";
		msg += result+" ";
		msg += params.get("target").toString().toUpperCase();
		msg += " 입니다.";
		
		mav.addObject("remAmount", remAmount);
		mav.addObject("calcResult", msg);
		mav.setViewName("table"); 
		
		return mav; 
	}
	
}
