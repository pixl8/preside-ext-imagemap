component output=false {

	property name="assetManagerService" inject="assetManagerService";

	public string function RichEditor( event, rc, prc, args={} ){
		var imagemap = trim( args.imagemap ?: "" );

		if ( len( imagemap ) && isJSON( imagemap ) && event.getValue( "action", "" ) != "assetManager.renderEmbeddedImageForEditor" ) {
			var areas   = deserializeJSON( imagemap ).areas;
			var area    = {};
			var mapArea = {};

			args.mapId    = "map-" & createUUID();
			args.mapAreas = [];

			for( area in areas ) {
				mapArea        = {};
				mapArea.shape  = area.type;
				mapArea.href   = area.attributes.link;
				mapArea.target = area.attributes.target == "_self" ? "" : area.attributes.target;
				mapArea.alt    = area.attributes.alt;

				if( Len( Trim( area.attributes.asset ?: "" ) )){
					mapArea.href = event.buildLink( assetId=area.attributes.asset );
				}
				if( Len( Trim( area.attributes.page ?: ""  ) )){
					mapArea.href = event.buildLink( page=area.attributes.page );
				}

				switch( area.type ) {
					case "rectangle":
						mapArea.coords = "#area.coords.x#,#area.coords.y#,#area.coords.x+area.coords.width#,#area.coords.y+area.coords.height#";
						break;
					case "circle":
						mapArea.coords = "#area.coords.cx#,#area.coords.cy#,#area.coords.radius#";
						break;
					case "polygon":
						mapArea.coords = "";
						for( var point in area.coords.points ) {
							mapArea.coords = listAppend( mapArea.coords, "#point.x#,#point.y#" );
						}
						break;
				}

				if ( len( mapArea.href ) & len( mapArea.coords ) ) {
					args.mapAreas.prepend( mapArea );
				}
			}
		}

		if ( Len( Trim( args.dimensions ?: "" ) ) && ListLen( args.dimensions, "x" ) == 2 ) {
			var width   = Val( ListFirst( args.dimensions, "x" ) );
			var height  = Val( ListLast( args.dimensions, "x" ) );
			var transformArgs = { width=width, height=height, maintainAspectRatio=true };

			if ( width && height ) {
				args.derivative = "#width#x#height#";

				if ( Len( Trim( args.quality ?: "" ) ) ) {
					args.derivative &= "-#args.quality#";
					transformArgs.quality = args.quality;
				}

				assetManagerService.createAssetDerivativeWhenNotExists(
					  assetId         = ( args.id ?: "" )
					, derivativeName  = args.derivative
					, transformations = [ { method="resize", args=transformArgs } ]
				);
			}
		}

		return renderView( view="/renderers/asset/image/richEditor", args=args );
	}

}