var app = angular.module("computer", ["ngRoute"])

.config(["$routeProvider", function($routeProvider){
	$routeProvider.
		when("/",{
			templateUrl: "perfil.html",
			controller: "StudentCtrl"
		}).
		when("/hAsist",{
			templateUrl: "Asistencia.html",
			controller: "StudentCtrl"
		}).
		when("/hTutor",{
			templateUrl: "Tutorias.html",
			controller: "StudentCtrl"
		}).
		when("/hEst",{
			templateUrl: "horasEstudiante.html",
			controller: "StudentCtrl"
		}).
		when("/asistEsp",{
			templateUrl: "aEspecial.html",
			controller: "StudentCtrl"
		}).
		when("/historial",{
			templateUrl: "historial.html",
			controller: "StudentCtrl"
		}).
		when("/borradores",{
			templateUrl: "borradores.html",
			controller: "StudentCtrl"
		}).
		when("/borrador",{
			templateUrl: "borrador.html",
			controller: "StudentCtrl"
		}).
		otherwise({
			redirectTo: "/"
		});
	}])

.controller("StudentCtrl",["$scope", "$http",function($scope, $http, $location, MyService){
	$scope.strCarne = "";
	$scope.profesores = [{Nombre:"Marco", ID:1},{Nombre:"Isaac", ID:2},{Nombre:"Diego", ID:3}];

	function imgToBase64(file,scp) {
		if(file!=null){
			var reader = new FileReader();
			reader.onload = function(){
		        //alert(reader.result);
		        //$scope.strCarne = reader.result;
		        aisgnarImg(reader.result, scp);
		    };
		    reader.readAsDataURL(file);
		}
		else{
			$scope.strCarne = "";
		}
	    
	};

	function aisgnarImg(img,scp) {
		if(scp==0){
			$scope.strCarne = img;
		}
	};

	function errorImg() {
		var errImg = false;
		if($scope.strCarne==""){
			alert("Debe adjuntar una imagen para carné");
		}
		else{
			errImg = true;
		}
		return errImg;
	};

		$scope.solicitudes = [{"ID":115, "Fecha de Solicitud":"04/02", "Hora de Solicitud":"11:14AM", "Estado":"Pendiente"},{"ID":191, "Fecha de Solicitud":"05/02", "Hora de Solicitud":"08:52AM", "Estado":"Pendiente"}];
		var bank = "Banco Nacional";

       	$scope.bancoNacional = function(){
       			bank = document.getElementById('bancos').value;
        		document.getElementsByName('banco')[0].placeholder='20001';
        	};

        $scope.bancoPopular = function(){
        		bank = document.getElementById('bancos').value;
        		document.getElementsByName('banco')[0].placeholder='161';
        	};
        $scope.enviarHA = function(){
        	var fileCarne = document.getElementById('imgCarne').files[0];
	        imgToBase64(fileCarne,0);
	        var Data = {};
	        setTimeout(function(){
	        		if(errorImg()){
	        			var localTime = new Date();
		        		Data = {"cedula":$scope.cedula,
							"proPonGeneral":$scope.ppg,
							"proPonSemestral":$scope.pps,
							"creditosGeneral":$scope.cg,
							"creditosSemestre":$scope.cs,
							"cuentaBanco":$scope.bn,
							"banco":bank,
							"carne":$scope.carne,
							"horas":0,
							"imgPpg":$scope.strCarne,
							"imgPps":"YW55IGNhcm5hbCBwbGVhc3VyZS4=",
							"imgCg":"YW55IGNhcm5hbCBwbGVhc3VyZS4=",
							"imgCs":"YW55IGNhcm5hbCBwbGVhc3VyZS4=",
							"imgCBanco":"YW55IGNhcm5hbCBwbGVhc3VyZS4=",
							"imgCed":"YW55IGNhcm5hbCBwbGVhc3VyZS4=",
							"imgCar":"YW55IGNhcm5hbCBwbGVhc3VyZS4=",
							"idCurso":parseInt(document.getElementById('curso').value),
							"idProfesor":parseInt(document.getElementById('profesor').value),
							"notaCurso":$scope.notaCurso,
							"imgNotaCurso":"YW55IGNhcm5hbCBwbGVhc3VyZS4=",
							"fecha":localTime,
							"telefono":$scope.telefono,
							"anosTEC":$scope.anTEC,
							"estado":0,
							"otrasAsistenciasDesc": ["uno","dos"],
							"otrasAsistenciasHoras":[5,78]};
							console.log(Data);alert("Su solicitud ha sido enviada");
	        		}
			       
					
					/*$http.post("http://192.168.100.7/api/Solicitudes?codigo=S01", Data).
		        	then(function(response) {
		            	$scope.res = response.data;
		            	console.log($scope.res);
		        	});*/
					
			    }, 500);
        		
				
        		
        	};
        $scope.guardarHA = function(){
	          alert(typeof parseInt(document.getElementById('profesor').value));
        	};
        $scope.cancelar = function(){
        		confirm("¿Desea cancelar la solicitud seleccionada?")
        		alert("La cancelación de su solicitud ha sido solicitada");
        	};
        $scope.abrirBorrador = function(){
        		window.location.href = "#!borrador"
        	};
        $scope.atras = function(){
        		window.location.href = "#!borradores"
        	};

}]);
