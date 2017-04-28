<cfscript>
	inputName    = args.name         ?: "";
	inputId      = args.id           ?: "";
	defaultValue = args.defaultValue ?: "";

	value  = event.getValue( name=inputName, defaultValue=defaultValue );
	if ( not IsSimpleValue( value ) ) {
		value = "";
	}

	event.include( "/css/admin/specific/image-map/" );
	event.include( "/js/admin/specific/image-map/" );
</cfscript>

<cfoutput>
	<div id="imageMapControls">
		<div class="btn-toolbar" role="toolbar">
			<div class="btn-group" role="group">
				<a href="##" class="btn btn-default" id="imageMapReload" title="#translateResource( uri="formcontrols.imageMap:controls.reloadImage.label" )#"><i class="fa fa-repeat"></i></a>
			</div>
			
			<div class="btn-group" role="group">
				<a href="##" class="btn btn-default imageMapAddArea" disabled data-shape="rectangle" title="#translateResource( uri="formcontrols.imageMap:controls.addRectangle.label" )#">#translateResource( uri="formcontrols.imageMap:shape.rect" )#</a>
				<a href="##" class="btn btn-default imageMapAddArea" disabled data-shape="circle" title="#translateResource( uri="formcontrols.imageMap:controls.addCircle.label" )#">#translateResource( uri="formcontrols.imageMap:shape.circle" )#</a>
				<a href="##" class="btn btn-default imageMapAddArea" disabled data-shape="polygon" title="#translateResource( uri="formcontrols.imageMap:controls.addPolygon.label" )#">#translateResource( uri="formcontrols.imageMap:shape.poly" )#</a>
			</div>
			
			<div class="btn-group" role="group">
				<a href="##" class="btn btn-default" disabled id="imageMapRemoveArea" title="#translateResource( uri="formcontrols.imageMap:controls.removeArea.label" )#"><i class="fa fa-trash-o"></i></a>
			</div>
		</div>
	</div>

	<div id="imageMapContainer">
		<img src="" alt="##" id="imageMapImage" />
		<svg xmlns="http://www.w3.org/2000/svg" version="1.2" baseProfile="tiny" id="imageMapSvg"></svg>
	</div>

	<input type="hidden" name="#inputName#" id="#inputId#" value="#HtmlEditFormat( value )#">
</cfoutput>
