var app = angular.module("computer", ["ngRoute"])

.config(["$routeProvider", function($routeProvider){
	$routeProvider.
		when("/",{
			templateUrl: "perfil.html",
			controller: "AdminCtrl"
		}).
		when("/rev",{
			templateUrl: "revision.html",
			controller: "AdminCtrl"
		}).
    when("/hAsistR",{
      templateUrl: "AsistenciaR.html",
      controller: "AdminCtrl"
    }).
    when("/hTutorR",{
      templateUrl: "TutoriasR.html",
      controller: "AdminCtrl"
    }).
    when("/hEstR",{
      templateUrl: "horasEstudianteR.html",
      controller: "AdminCtrl"
    }).
    when("/asistEspR",{
      templateUrl: "aEspecialR.html",
      controller: "AdminCtrl"
    }).
		when("/config",{
			templateUrl: "config.html",
			controller: "AdminCtrl"
		}).
		when("/rep",{
			templateUrl: "reportes.html",
			controller: "AdminCtrl"
		}).
		when("/eval",{
			templateUrl: "evaluación.html",
			controller: "AdminCtrl"
		}).
    when("/evaluar",{
      templateUrl: "evaluarEstudiante.html",
      controller: "AdminCtrl"
    }).
    when("/req",{
      templateUrl: "requerimientos.html",
      controller: "AdminCtrl"
    }).
    when("/evaluar",{
      templateUrl: "evaluarEstudiante.html",
      controller: "AdminCtrl"
    }).
    when("/ingUsuario",{
      templateUrl: "ingresarUsuario.html",
      controller: "AdminCtrl"
    }).
    when("/actUsuario",{
      templateUrl: "actualizarUsuario.html",
      controller: "AdminCtrl"
    }).
		when("/becasTEC",{
			templateUrl: "rBecasTEC.html",
			controller: "AdminCtrl"
		}).
		when("/trabajoSocial",{
			templateUrl: "rTrabajoSocial.html",
			controller: "AdminCtrl"
		}).
		otherwise({
			redirectTo: "/"
		});
	}])

.controller("AdminCtrl",["$scope", "$http",function($scope, $http, $location, MyService){
		$scope.hAsist = [{"Nombre":"Kevin", "Apellido 1":"Acuña", "Apellido 2":"Mena", "Carné":2015093739,"Estado":"Pendiente"},{"Nombre":"Verónica", "Apellido 1":"Brenes", "Apellido 2":"Benzoni", "Carné":2015069077, "Estado":"Pendiente"}];
    $scope.hTutor = [{"Nombre":"Efrén", "Apellido 1":"Carvajal", "Apellido 2":"Valverde", "Carné":2015019679, "Estado":"Pendiente"}];
    $scope.hEst = [{"Nombre":"Diego", "Apellido 1":"Solís", "Apellido 2":"Jiménez", "Carné":2014027244, "Estado":"Pendiente"}];
    $scope.asistEsp = [{"Nombre":"Stephanie", "Apellido 1":"Padilla", "Apellido 2":"Castro", "Carné":2014506325, "Estado":"Pendiente"}];
    $scope.estudiantes = [{"Nombre":"Kevin", "Apellido 1":"Acuña", "Apellido 2":"Mena", "Carné":2015093739,"Estado":"Pendiente"},
                          {"Nombre":"Verónica", "Apellido 1":"Brenes", "Apellido 2":"Benzoni", "Carné":2015069077, "Estado":"Pendiente"},
                          {"Nombre":"Efrén", "Apellido 1":"Carvajal", "Apellido 2":"Valverde", "Carné":2015019679, "Estado":"Pendiente"},
                          {"Nombre":"Diego", "Apellido 1":"Solís", "Apellido 2":"Jiménez", "Carné":2014027244, "Estado":"Pendiente"},
                          {"Nombre":"Stephanie", "Apellido 1":"Padilla", "Apellido 2":"Castro", "Carné":2014506325, "Estado":"Pendiente"}];
		$scope.reporte1 = [{"Nombre":"Kevin", "Apellido 1":"Acuña", "Apellido 2":"Mena", "Carné":2015093739, "Promedio Ponderado":90, "Horas Asignadas":150, "Beca":"Horas Asistente"},
						   {"Nombre":"Verónica", "Apellido 1":"Brenes", "Apellido 2":"Benzoni", "Carné":2015069077, "Promedio Ponderado":85, "Horas Asignadas":100, "Beca":"Horas Asistente"},
						   {"Nombre":"Efrén", "Apellido 1":"Carvajal", "Apellido 2":"Valverde", "Carné":2015019679, "Promedio Ponderado":85, "Horas Asignadas":100, "Beca":"Tutor"},
						   {"Nombre":"Diego", "Apellido 1":"Solís", "Apellido 2":"Jiménez", "Carné":2014027244, "Promedio Ponderado":80, "Horas Asignadas":150, "Beca":"Horas Estudiante"},
						   {"Nombre":"Stephanie", "Apellido 1":"Padilla", "Apellido 2":"Castro", "Carné":2014506325, "Promedio Ponderado":70, "Horas Asignadas":50, "Beca":"Asistencia Especial"}];
		$scope.reporte3 = [{"Nombre":"Kevin", "Apellido 1":"Acuña", "Apellido 2":"Mena", "Carné":2015093739, "Horas":150, "Beca":"Horas Asistente", "Cuenta Bancaria":161565186, "Banco":"Banco Popular"},
						   {"Nombre":"Verónica", "Apellido 1":"Brenes", "Apellido 2":"Benzoni", "Carné":2015069077, "Horas":100, "Beca":"Horas Asistente", "Cuenta Bancaria":161581519, "Banco":"Banco Popular"},
						   {"Nombre":"Efrén", "Apellido 1":"Carvajal", "Apellido 2":"Valverde", "Carné":2015019679, "Horas":100, "Beca":"Tutor", "Cuenta Bancaria":2001564856, "Banco":"Banco Nacional"},
						   {"Nombre":"Diego", "Apellido 1":"Solís", "Apellido 2":"Jiménez", "Carné":2014027244, "Horas":150, "Beca":"Horas Estudiante", "Cuenta Bancaria":200147818, "Banco":"Banco Nacional"},
						   {"Nombre":"Stephanie", "Apellido 1":"Padilla", "Apellido 2":"Castro", "Carné":2014506325, "Horas":50, "Beca":"Asistencia Especial", "Cuenta Bancaria":161879556, "Banco":"Banco Popular"}];

        $scope.abrirRequerimientos = function(){
        		var myWindow = window.open("requerimientos.html", "", "width=640,height=480");
        	};

        $scope.abrirEvaluacion = function(){
        		var myWindow = window.open("evaluarEstudiante.html", "", "width=640,height=480");
        	};
        $scope.atrasEv = function(){
        		window.location.href = "#!eval";
        	};
        $scope.atrasReq = function(){
        		window.location.href = "#!hAsistR";
        	};

        $scope.generarBecas = function(){
                //var data = $scope.reporte3;

                JSONToCSVConvertor($scope.reporte3, "Departamento de Becas", true);
            };

        $scope.generarTSocial = function(){
                var data = $scope.reporte1;

                JSONToCSVConvertor($scope.reporte1, "Trabajo Social", true);
            };
        $scope.denegar = function(){
                prompt("Justifique el denegado")
            };
        $scope.aceptar = function(){
                alert("Estudiante aprobado")
            };
        $scope.guardarConfig = function(){
                alert("Configuración guardada")
            };
        $scope.enviar = function(){
                alert("Observaciones enviadas")
            };

        function JSONToCSVConvertor(JSONData, ReportTitle, ShowLabel) {
            //If JSONData is not an object then JSON.parse will parse the JSON string in an Object
            var arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData;
            
            var CSV = 'sep=,' + '\r\n\n';

            //This condition will generate the Label/Header
            if (ShowLabel) {
                var row = "";
                var len = 0;
                
                //This loop will extract the label from 1st index of on array
                for (var index in arrData[0]) {
                    
                    //Now convert each value to string and comma-seprated
                    row += index + ',';
                }

                row = row.slice(0, -11);
                
                //append Label row with line break
                CSV += row + '\r\n';
            }
            
            //1st loop is to extract each row
            for (var i = 0; i < arrData.length; i++) {
                var row = "";
                
                //2nd loop will extract each column and convert it in string comma-seprated
                for (var index in arrData[i]) {
                    row += '"' + arrData[i][index] + '",';
                    len = arrData[i][index].length+3;
                }

                row = row.slice(0, -(len+1));
                
                //add a line break after each row
                CSV += row + '\r\n';
            }

            if (CSV == '') {        
                alert("Invalid data");
                return;
            }   
            
            //Generate a file name
            var fileName = "Reporte_";
            //this will remove the blank-spaces from the title and replace it with an underscore
            fileName += ReportTitle.replace(/ /g,"_");   
            
            //Initialize file format you want csv or xls
            var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);
            
            // Now the little tricky part.
            // you can use either>> window.open(uri);
            // but this will not work in some browsers
            // or you will not get the correct file extension    
            
            //this trick will generate a temp <a /> tag
            var link = document.createElement("a");    
            link.href = uri;
            
            //set the visibility hidden so it will not effect on your web-layout
            link.style = "visibility:hidden";
            link.download = fileName + ".csv";
            
            //this part will append the anchor tag and remove it after automatic click
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        }
}]);
