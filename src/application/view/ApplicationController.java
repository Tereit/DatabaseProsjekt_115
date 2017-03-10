package application.view;

import application.MainApp;
import application.model.AppController;

public class ApplicationController implements AppController {

	
	private MainApp mainApp;
	
	@Override
	public void setMainApp(MainApp mainApp) {
		// TODO Auto-generated method stub
		this.mainApp = mainApp;
	}

}
