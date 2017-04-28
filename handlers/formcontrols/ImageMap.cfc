component output=false {

	public string function index( event, rc, prc, args={} ) output=false {
		
		return renderView( view="formcontrols/imageMap/index", args=args );
	}

}