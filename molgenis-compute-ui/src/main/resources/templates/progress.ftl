		var PAPER_WIDTH = 600;
		var PAPER_HEIGHT = 300;
		var RECT_WIDTH = 200;
		var RECT_HEIGHT = 20;
		
		$('#paper').unbind();
		$('#paper').empty();
	
		var graph = new joint.dia.Graph;
		var paper = new joint.dia.Paper({
			el: $('#paper'),
			width: PAPER_WIDTH,
			height: PAPER_HEIGHT,
			model: graph,
			interactive: false
		});
		
		graph.clear();
		
		var rects = {
		<#list analysis.workflow.nodes as node>
			'${node.identifier?js_string}': new joint.shapes.basic.Rect({
				id: '${node.identifier?js_string}',
				size: { 
					width: RECT_WIDTH, 
					height: RECT_HEIGHT
				},
				attrs: {
        			rect: {
            			fill:'#5B82A4',
            			cursor: 'pointer'
        			},
        			text: {
            			text: '${node.name?js_string}',
           	 			fill: '#fefefe',
            			'font-size': 12,
            			'font-weight': 'bold', 
            			'font-variant': 'small-caps',
            			cursor: 'pointer'
        			}
    			}
			}),
		</#list>
		}

		_.each(rects, function(rect) { 
			graph.addCell(rect); 
		});

		<#list analysis.workflow.nodes as node>
			<#if node.previousNodes?has_content>
				<#list node.previousNodes as prevNode>
				 	graph.addCell(new joint.dia.Link({
    					source: { id: rects['${prevNode.identifier?js_string}'].id },
    					target: { id: rects['${node.identifier?js_string}'].id},
    					attrs: {
        					'.connection': {
            				stroke: '#333333',
            				'stroke-width': 3
        				},
        				'.marker-target': {
            				fill: '#333333',
            				d: 'M 10 0 L 0 5 L 10 10 z'
        				}
    				}}));
				</#list>
			</#if>
		</#list>
	
		joint.layout.DirectedGraph.layout(graph, { setLinkVertices: false });
		paper.fitToContent();
