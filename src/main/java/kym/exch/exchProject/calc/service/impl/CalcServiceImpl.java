package kym.exch.exchProject.calc.service.impl;

import java.util.Map;
import org.springframework.stereotype.Service;
import kym.exch.exchProject.calc.service.CalcService;

@Service("CalcService")
public class CalcServiceImpl implements CalcService {
	
	public String calcRate(Map<String, Object> params) {
		float exchageRate = Float.parseFloat(params.get("excNum").toString());
		float remAmount = Float.parseFloat(params.get("remAmount").toString());
		
		String result = String.format("%,.2f", (exchageRate * remAmount));
		return result;
	}
	
}
