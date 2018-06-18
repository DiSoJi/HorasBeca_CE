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
		when("/hAsistH",{
			templateUrl: "AsistenciaH.html",
			controller: "StudentCtrl"
		}).
		when("/hTutorH",{
			templateUrl: "TutoriasH.html",
			controller: "StudentCtrl"
		}).
		when("/hEstH",{
			templateUrl: "horasEstudianteH.html",
			controller: "StudentCtrl"
		}).
		when("/asistEspH",{
			templateUrl: "aEspecialH.html",
			controller: "StudentCtrl"
		}).
		when("/hAsistHL",{
			templateUrl: "AsistenciaHL.html",
			controller: "StudentCtrl"
		}).
		when("/hTutorHL",{
			templateUrl: "TutoriasHL.html",
			controller: "StudentCtrl"
		}).
		when("/hEstHL",{
			templateUrl: "horasEstudianteHL.html",
			controller: "StudentCtrl"
		}).
		when("/asistEspHL",{
			templateUrl: "aEspecialHL.html",
			controller: "StudentCtrl"
		}).
		when("/hAsistB",{
			templateUrl: "AsistenciaB.html",
			controller: "StudentCtrl"
		}).
		when("/hTutorB",{
			templateUrl: "TutoriasB.html",
			controller: "StudentCtrl"
		}).
		when("/hEstB",{
			templateUrl: "horasEstudianteB.html",
			controller: "StudentCtrl"
		}).
		when("/asistEspB",{
			templateUrl: "aEspecialB.html",
			controller: "StudentCtrl"
		}).
		when("/hAsistBL",{
			templateUrl: "AsistenciaBL.html",
			controller: "StudentCtrl"
		}).
		when("/hTutorBL",{
			templateUrl: "TutoriasBL.html",
			controller: "StudentCtrl"
		}).
		when("/hEstBL",{
			templateUrl: "horasEstudianteBL.html",
			controller: "StudentCtrl"
		}).
		when("/asistEspBL",{
			templateUrl: "aEspecialBL.html",
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
	$scope.perfil = localStorage.perfil;
	  for(i in $scope.perfil){
	        $scope.perfil = $scope.perfil.replace("%7B","{");
	    $scope.perfil = $scope.perfil.replace("%22","\"");
	    $scope.perfil = $scope.perfil.replace("%7D","}");
	    };          
	    $scope.perfil = JSON.parse($scope.perfil);
	    console.log($scope.perfil);
	$scope.nombre = $scope.perfil.primer_nombre + " " + $scope.perfil.segundo_nombre;
	$scope.primerApellido = $scope.perfil.primer_apellido;
	$scope.segundoApellido = $scope.perfil.segundo_apellido;
	$scope.carne = parseInt($scope.perfil.carne);
	$scope.correo = $scope.perfil.correo_electronico;
	$scope.res = {};
	$scope.tabla = {};
	$scope.horasAE = 0;
	$scope.strCarne = "";
	$scope.strCedula = "";
	$scope.strPpg = "";
	$scope.strPps = "";
	$scope.strCs = "";
	$scope.strCg = "";
	$scope.strNota = "";
	$scope.strCuenta = "";
	$scope.profesores = [{Nombre:"Marco", ID:1},{Nombre:"Isaac", ID:1},{Nombre:"Diego", ID:1}];
	$scope.cursos = [{Nombre:"Marco", ID:"CE4101"},{Nombre:"Isaac", ID:"CE4101"},{Nombre:"Diego", ID:"CE4101"}];
	$scope.departamentos = [];
	$scope.horasDepartamento = [];
	$scope.valid = true;
	var bank = "Banco Nacional";

	function imgToBase64(file,scp) {
		if(file!=null){
			var reader = new FileReader();
			reader.onload = function(){
		        asignarImg(reader.result, scp);
		    };
		    reader.readAsDataURL(file);
		}
	    
	};

	function asignarImg(img,scp) {
		if(scp==0){
			$scope.strCarne = btoa(img);
		}
		if(scp==1){
			$scope.strCedula = btoa(img);
		}
		if(scp==2){
			$scope.strPps = btoa(img);
		}
		if(scp==3){
			$scope.strPpg = btoa(img);
		}
		if(scp==4){
			$scope.strCs = btoa(img);
		}
		if(scp==5){
			$scope.strCg = btoa(img);
		}
		if(scp==6){
			$scope.strNota = btoa(img);
		}
		if(scp==7){
			$scope.strCuenta = btoa(img);
		}
	};

	function errorImg() {
		var errImg = false;
		if($scope.strCarne==""){
			alert("Debe adjuntar una imagen para carné");
		}
		if($scope.strCedula==""){
			alert("Debe adjuntar una imagen para cédula");
		}
		if($scope.strPps==""){
			alert("Debe adjuntar una imagen para promedio ponderado del semestre anterior");
		}
		if($scope.strPpg==""){
			alert("Debe adjuntar una imagen para promedio ponderado general");
		}
		if($scope.strCs==""){
			alert("Debe adjuntar una imagen para créditos aprobados el semestre anterior");
		}
		if($scope.strCg==""){
			alert("Debe adjuntar una imagen para créditos aprobados");
		}
		if($scope.strCuenta==""){
			alert("Debe adjuntar una imagen para cuenta del banco");
		}
		else{
			errImg = true;
		}
		return errImg;
	};

       	$scope.bancoNacional = function(){
       			bank = document.getElementById('bancos').value;
        		document.getElementsByName('banco')[0].placeholder='20001';
        	};

        $scope.bancoPopular = function(){
        		bank = document.getElementById('bancos').value;
        		document.getElementsByName('banco')[0].placeholder='161';
        	};

        $scope.agregarOtrasBecas = function(){
        	if($scope.otraHora!=undefined){
        		$scope.departamentos.push($scope.otraEscuela);
        		$scope.horasDepartamento.push($scope.otraHora);
        		$scope.otraEscuela = "";
        		$scope.otraHora = "";
        		console.log($scope.departamentos);
        		console.log($scope.horasDepartamento);
        	}else{
        		alert("Debe ingresar un número como horas");
        	}
        	};
        $scope.cancelar = function(){
        		confirm("¿Desea cancelar la solicitud seleccionada?")
        		alert("La cancelación de su solicitud ha sido solicitada");
        	};
        $scope.abrirBorrador = function(){
        		window.location.href = "#!borrador"
        	};
        $scope.test = function(){
        		alert($scope.strCarne);
        	};
        $scope.atras = function(){
        		var dir = window.location.href.toString().split("?")[0].split("/")[window.location.href.toString().split("?")[0].split("/").length - 1];
        		window.location.href = "#!" + dir + "L";
        	};
        $scope.selectRow = function(){
        	var table = document.getElementById('table');
        	var ID = 0;
                for(var i = 1; i < table.rows.length; i++)
                {
                    table.rows[i].onclick = function()
                    {
                    	ID = this.cells[0].innerHTML;
                    };
                }
                setTimeout(function(){
                	var res = {};
	        		for(var j in $scope.solicitudes){
	        			if($scope.solicitudes[j].ID==ID){
	        				res = $scope.solicitudes[j];
	        			}
	        		}
	        		delete res["$$hashKey"];
	        		var res = JSON.stringify(res);
	        		console.log(res);
	        		var dir = window.location.href.toString().split("/")[window.location.href.toString().split("/").length - 1];
	        		alert(dir);
	        		window.location.href = "#!" + dir.replace("L","") + "?" + res;
			        	}, 500);
        	};
       	$scope.loadJSON = function(){
       		$scope.data = window.location.href.toString().split("?")[1];
	       	for(i in $scope.data){
	       		$scope.data = $scope.data.replace("%7B","{");
				$scope.data = $scope.data.replace("%22","\"");
				$scope.data = $scope.data.replace("%7D","}");
	       	};        	
	       	$scope.data = JSON.parse($scope.data);
	       	console.log($scope.data);
       	};
       	$scope.loadHist = function(){
       		/*$http.get("http://webapi220171117104514.azurewebsites.net/api/proveedor").
        	then(function(response) {
            	$scope.proveedores = response.data.Proveedores;
        	});*/
       		$scope.solicitudes = [{"ID":115, "Fecha de Solicitud":"04/02", "Hora de Solicitud":"11:14AM", "Estado":"Pendiente"},{"ID":191, "Fecha de Solicitud":"05/02", "Hora de Solicitud":"08:52AM", "Estado":"Pendiente"}];
       	};
        $scope.loadBorrador = function(){
       		$scope.solicitudes = [{"ID":115, "Fecha de Solicitud":"04/02", "Hora de Solicitud":"11:14AM", "Estado":"Pendiente"},{"ID":191, "Fecha de Solicitud":"05/02", "Hora de Solicitud":"08:52AM", "Estado":"Pendiente"}];
       	};

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//FUNCIONES PARA ASISTENCIA ESPECIAL//
///////////////////////////////////////////////////////////////////////////////////////////////////////// 
		$scope.enviarAE = function(){
        	var fileCarne = document.getElementById('imgCarne').files[0];
	        imgToBase64(fileCarne,0);
	        var fileCedula = document.getElementById('imgCedula').files[0];
	        imgToBase64(fileCedula,1);
	        var filePps = document.getElementById('imgPps').files[0];
	        imgToBase64(filePps,2);
	        var filePpg = document.getElementById('imgPpg').files[0];
	        imgToBase64(filePpg,3);
	        var fileCs = document.getElementById('imgCs').files[0];
	        imgToBase64(fileCs,4);
	        var fileCg = document.getElementById('imgCg').files[0];
	        imgToBase64(fileCg,5);
	        var fileCuenta = document.getElementById('imgCuenta').files[0];
	        imgToBase64(fileCuenta,7);
	        var Data = {};
	        if(document.getElementById("10h").checked){
	        	$scope.horasAE = $scope.horasAE + 10;
	        }
	        if(document.getElementById("20h").checked){
	        	$scope.horasAE = $scope.horasAE + 10;
	        }
	        setTimeout(function(){
	        		if(errorImg()){
	        			var localTime = new Date();
		        		Data = {"tipoSolicitud": "AE",
							"carrera":1,
		        			"cedula":$scope.cedula,
							"proPonGeneral":$scope.ppg,
							"proPonSemestral":$scope.pps,
							"creditosGeneral":$scope.cg,
							"creditosSemestre":$scope.cs,
							"cuentaBanco":$scope.bn,
							"banco":bank,
							"carne":$scope.carne,
							"horas":$scope.horasAE,
							"imgPpg":$scope.strPpg,
							"imgPps":$scope.strPps,
							"imgCg":$scope.strCg,
							"imgCs":$scope.strCs,
							"imgCBanco":$scope.strCuenta,
							"imgCed":$scope.strCedula,
							"imgCar":$scope.strCarne,
							"idCurso":"",
							"idProfesor":0,
							"notaCurso":0,
							"imgNotaCurso":"YW55IGNhcm5hbCBwbGVhc3VyZS4=",
							"fecha":localTime,
							"telefono":$scope.telefono,
							"anosTEC":$scope.anTEC,
							"estado":1,
							"otrasAsistenciasDesc": $scope.departamentos,
							"otrasAsistenciasHoras": $scope.horasDepartamento};
							console.log(Data);
							$http.post("http://localhost:7010/api/Solicitudes?codigo=S01", Data).
				        	then(function(response) {
				            	$scope.res = response.data;
				            	console.log($scope.res);
				            	alert("Su solicitud ha sido enviada");
				        	});
	        		}	
			    }, 500);
        	};
        $scope.guardarAE = function(){
	        var fileCarne = document.getElementById('imgCarne').files[0];
	        imgToBase64(fileCarne,0);
	        var fileCedula = document.getElementById('imgCedula').files[0];
	        imgToBase64(fileCedula,1);
	        var filePps = document.getElementById('imgPps').files[0];
	        imgToBase64(filePps,2);
	        var filePpg = document.getElementById('imgPpg').files[0];
	        imgToBase64(filePpg,3);
	        var fileCs = document.getElementById('imgCs').files[0];
	        imgToBase64(fileCs,4);
	        var fileCg = document.getElementById('imgCg').files[0];
	        imgToBase64(fileCg,5);
	        var fileCuenta = document.getElementById('imgCuenta').files[0];
	        imgToBase64(fileCuenta,7);
	        var Data = {};
	        if(document.getElementById("10h").checked){
	        	$scope.horasAE = $scope.horasAE + 10;
	        }
	        if(document.getElementById("20h").checked){
	        	$scope.horasAE = $scope.horasAE + 10;
	        }
	        setTimeout(function(){
	        		if(errorImg()){
	        			var localTime = new Date();
		        		Data = {"tipoSolicitud": "AE",
							"carrera":1,
		        			"cedula":$scope.cedula,
							"proPonGeneral":$scope.ppg,
							"proPonSemestral":$scope.pps,
							"creditosGeneral":$scope.cg,
							"creditosSemestre":$scope.cs,
							"cuentaBanco":$scope.bn,
							"banco":bank,
							"carne":$scope.carne,
							"horas":$scope.horasAE,
							"imgPpg":$scope.strPpg,
							"imgPps":$scope.strPps,
							"imgCg":$scope.strCg,
							"imgCs":$scope.strCs,
							"imgCBanco":$scope.strCuenta,
							"imgCed":$scope.strCedula,
							"imgCar":$scope.strCarne,
							"idCurso":"",
							"idProfesor":0,
							"notaCurso":0,
							"imgNotaCurso":"YW55IGNhcm5hbCBwbGVhc3VyZS4=",
							"fecha":localTime,
							"telefono":$scope.telefono,
							"anosTEC":$scope.anTEC,
							"estado":1,
							"otrasAsistenciasDesc": $scope.departamentos,
							"otrasAsistenciasHoras": $scope.horasDepartamento};
							console.log(Data);
							$http.post("http://localhost:7010/api/Solicitudes?codigo=S01", Data).
				        	then(function(response) {
				            	$scope.res = response.data;
				            	console.log($scope.res);
				            	alert("Su borrador ha sido guardado");
				        	});
	        		}	
			    }, 500);
        	};       
        

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//FUNCIONES PARA HORAS ASISTENTE//
/////////////////////////////////////////////////////////////////////////////////////////////////////////        
        $scope.enviarHA = function(){
        	var fileCarne = document.getElementById('imgCarne').files[0];
	        imgToBase64(fileCarne,0);
	        var fileCedula = document.getElementById('imgCedula').files[0];
	        imgToBase64(fileCedula,1);
	        var filePps = document.getElementById('imgPps').files[0];
	        imgToBase64(filePps,2);
	        var filePpg = document.getElementById('imgPpg').files[0];
	        imgToBase64(filePpg,3);
	        var fileCs = document.getElementById('imgCs').files[0];
	        imgToBase64(fileCs,4);
	        var fileCg = document.getElementById('imgCg').files[0];
	        imgToBase64(fileCg,5);
	        var fileNota = document.getElementById('imgNotaCurso').files[0];
	        imgToBase64(fileNota,6);
	        var fileCuenta = document.getElementById('imgCuenta').files[0];
	        imgToBase64(fileCuenta,7);
	        var Data = {};
	        setTimeout(function(){
	        		if(errorImg()){
	        			var localTime = new Date();
		        		Data = {"tipoSolicitud": "HA",
								"carrera":1,
								"cedula" : $scope.cedula,
								"proPonGeneral":$scope.ppg,
								"proPonSemestral":$scope.pps,
								"creditosGeneral":$scope.cg,
								"creditosSemestre":$scope.cs,
								"cuentaBanco":$scope.bn,
								"banco":bank,
								"carne":$scope.carne,
								"horas":0,
								"imgPpg":$scope.strPpg,
								"imgPps":$scope.strPps,
								"imgCg":$scope.strCg,
								"imgCs":$scope.strCs,
								"imgCBanco":$scope.strCuenta,
								"imgCed":$scope.strCedula,
								"imgCar":$scope.strCarne,
								"idCurso":document.getElementById('curso').value,
								"idProfesor":parseInt(document.getElementById('profesor').value),
								"notaCurso":$scope.notaCurso,
								"imgNotaCurso":$scope.strNota,
								"fecha":localTime,
								"telefono":$scope.telefono,
								"anosTEC":$scope.anTEC,
								"estado":1,
								"otrasAsistenciasDesc": $scope.departamentos,
								"otrasAsistenciasHoras":$scope.horasDepartamento
								}
							console.log(Data);
							
							$http.post("http://localhost:7010/api/Solicitudes?codigo=S01", Data).
				        	then(function(response) {
				            	$scope.res = response.data;
				            	console.log($scope.res);
				            	alert("Su solicitud ha sido enviada");
				        	});
	        		}	
			    }, 500);
        	};
        $scope.guardarHA = function(){
	        var fileCarne = document.getElementById('imgCarne').files[0];
	        imgToBase64(fileCarne,0);
	        var fileCedula = document.getElementById('imgCedula').files[0];
	        imgToBase64(fileCedula,1);
	        var filePps = document.getElementById('imgPps').files[0];
	        imgToBase64(filePps,2);
	        var filePpg = document.getElementById('imgPpg').files[0];
	        imgToBase64(filePpg,3);
	        var fileCs = document.getElementById('imgCs').files[0];
	        imgToBase64(fileCs,4);
	        var fileCg = document.getElementById('imgCg').files[0];
	        imgToBase64(fileCg,5);
	        var fileNota = document.getElementById('imgNotaCurso').files[0];
	        imgToBase64(fileNota,6);
	        var fileCuenta = document.getElementById('imgCuenta').files[0];
	        imgToBase64(fileCuenta,7);
	        var Data = {};
	        setTimeout(function(){
	        		if(errorImg()){
	        			var localTime = new Date();
		        		Data = {"tipoSolicitud": "HA",
								"carrera":1,
								"cedula" : $scope.cedula,
								"proPonGeneral":$scope.ppg,
								"proPonSemestral":$scope.pps,
								"creditosGeneral":$scope.cg,
								"creditosSemestre":$scope.cs,
								"cuentaBanco":$scope.bn,
								"banco":bank,
								"carne":$scope.carne,
								"horas":0,
								"imgPpg":$scope.strPpg,
								"imgPps":$scope.strPps,
								"imgCg":$scope.strCg,
								"imgCs":$scope.strCs,
								"imgCBanco":$scope.strCuenta,
								"imgCed":$scope.strCedula,
								"imgCar":$scope.strCarne,
								"idCurso":document.getElementById('curso').value,
								"idProfesor":parseInt(document.getElementById('profesor').value),
								"notaCurso":$scope.notaCurso,
								"imgNotaCurso":$scope.strNota,
								"fecha":localTime,
								"telefono":$scope.telefono,
								"anosTEC":$scope.anTEC,
								"estado":0,
								"otrasAsistenciasDesc": $scope.departamentos,
								"otrasAsistenciasHoras":$scope.horasDepartamento
								}
							console.log(Data);
							
							$http.post("http://localhost:7010/api/Solicitudes?codigo=S01", Data).
				        	then(function(response) {
				            	$scope.res = response.data;
				            	console.log($scope.res);
				            	alert("Su borrador ha sido guardado");
				        	});
	        		}	
			    }, 500);
        	};

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//FUNCIONES PARA HORAS TUTOR//
///////////////////////////////////////////////////////////////////////////////////////////////////////// 
        $scope.enviarHT = function(){
        	var fileCarne = document.getElementById('imgCarne').files[0];
	        imgToBase64(fileCarne,0);
	        var fileCedula = document.getElementById('imgCedula').files[0];
	        imgToBase64(fileCedula,1);
	        var filePps = document.getElementById('imgPps').files[0];
	        imgToBase64(filePps,2);
	        var filePpg = document.getElementById('imgPpg').files[0];
	        imgToBase64(filePpg,3);
	        var fileCs = document.getElementById('imgCs').files[0];
	        imgToBase64(fileCs,4);
	        var fileCg = document.getElementById('imgCg').files[0];
	        imgToBase64(fileCg,5);
	        var fileNota = document.getElementById('imgNotaCurso').files[0];
	        imgToBase64(fileNota,6);
	        var fileCuenta = document.getElementById('imgCuenta').files[0];
	        imgToBase64(fileCuenta,7);
	        var Data = {};
	        setTimeout(function(){
	        		if(errorImg()){
	        			var localTime = new Date();
		        		Data = {"tipoSolicitud": "HT",
							"carrera":1,
		        			"cedula":$scope.cedula,
							"proPonGeneral":$scope.ppg,
							"proPonSemestral":$scope.pps,
							"creditosGeneral":$scope.cg,
							"creditosSemestre":$scope.cs,
							"cuentaBanco":$scope.bn,
							"banco":bank,
							"carne":$scope.carne,
							"horas":0,
							"imgPpg":$scope.strPpg,
							"imgPps":$scope.strPps,
							"imgCg":$scope.strCg,
							"imgCs":$scope.strCs,
							"imgCBanco":$scope.strCuenta,
							"imgCed":$scope.strCedula,
							"imgCar":$scope.strCarne,
							"idCurso":document.getElementById("curso").value,
							"idProfesor":1,
							"notaCurso":$scope.notaCurso,
							"imgNotaCurso":$scope.strNota,
							"fecha":localTime,
							"telefono":$scope.telefono,
							"anosTEC":$scope.anTEC,
							"estado":1,
							"otrasAsistenciasDesc": $scope.departamentos,
							"otrasAsistenciasHoras": $scope.horasDepartamento};
							console.log(Data);
							
							$http.post("http://localhost:7010/api/Solicitudes?codigo=S01", Data).
				        	then(function(response) {
				            	$scope.res = response.data;
				            	console.log($scope.res);
				            	alert("Su solicitud ha sido enviada");
				        	});
	        		}	
			    }, 500);
        	};
        $scope.guardarHT = function(){
	        var fileCarne = document.getElementById('imgCarne').files[0];
	        imgToBase64(fileCarne,0);
	        var fileCedula = document.getElementById('imgCedula').files[0];
	        imgToBase64(fileCedula,1);
	        var filePps = document.getElementById('imgPps').files[0];
	        imgToBase64(filePps,2);
	        var filePpg = document.getElementById('imgPpg').files[0];
	        imgToBase64(filePpg,3);
	        var fileCs = document.getElementById('imgCs').files[0];
	        imgToBase64(fileCs,4);
	        var fileCg = document.getElementById('imgCg').files[0];
	        imgToBase64(fileCg,5);
	        var fileNota = document.getElementById('imgNotaCurso').files[0];
	        imgToBase64(fileNota,6);
	        var fileCuenta = document.getElementById('imgCuenta').files[0];
	        imgToBase64(fileCuenta,7);
	        var Data = {};
	        setTimeout(function(){
	        		if(errorImg()){
	        			var localTime = new Date();
		        		Data = {"tipoSolicitud": "HT",
							"carrera":1,
		        			"cedula":$scope.cedula,
							"proPonGeneral":$scope.ppg,
							"proPonSemestral":$scope.pps,
							"creditosGeneral":$scope.cg,
							"creditosSemestre":$scope.cs,
							"cuentaBanco":$scope.bn,
							"banco":bank,
							"carne":$scope.carne,
							"horas":0,
							"imgPpg":$scope.strPpg,
							"imgPps":$scope.strPps,
							"imgCg":$scope.strCg,
							"imgCs":$scope.strCs,
							"imgCBanco":$scope.strCuenta,
							"imgCed":$scope.strCedula,
							"imgCar":$scope.strCarne,
							"idCurso":document.getElementById("curso").value,
							"idProfesor":1,
							"notaCurso":$scope.notaCurso,
							"imgNotaCurso":$scope.strNota,
							"fecha":localTime,
							"telefono":$scope.telefono,
							"anosTEC":$scope.anTEC,
							"estado":0,
							"otrasAsistenciasDesc": $scope.departamentos,
							"otrasAsistenciasHoras": $scope.horasDepartamento};
							console.log(Data);
							
							$http.post("http://localhost:7010/api/Solicitudes?codigo=S01", Data).
				        	then(function(response) {
				            	$scope.res = response.data;
				            	console.log($scope.res);
				            	alert("Su borrador ha sido guardado");
				        	});
	        		}	
			    }, 500);
        	};

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//FUNCIONES PARA HORAS ESTUDIANTE//
///////////////////////////////////////////////////////////////////////////////////////////////////////// 
        $scope.enviarHE = function(){
        	var fileCarne = document.getElementById('imgCarne').files[0];
	        imgToBase64(fileCarne,0);
	        var fileCedula = document.getElementById('imgCedula').files[0];
	        imgToBase64(fileCedula,1);
	        var filePps = document.getElementById('imgPps').files[0];
	        imgToBase64(filePps,2);
	        var filePpg = document.getElementById('imgPpg').files[0];
	        imgToBase64(filePpg,3);
	        var fileCs = document.getElementById('imgCs').files[0];
	        imgToBase64(fileCs,4);
	        var fileCg = document.getElementById('imgCg').files[0];
	        imgToBase64(fileCg,5);
	        var fileCuenta = document.getElementById('imgCuenta').files[0];
	        imgToBase64(fileCuenta,7);
	        var Data = {};
	        setTimeout(function(){
	        		if(errorImg()){
	        			var localTime = new Date();
		        		Data = {"tipoSolicitud": "HE",
							"carrera":1,
		        			"cedula":$scope.cedula,
							"proPonGeneral":$scope.ppg,
							"proPonSemestral":$scope.pps,
							"creditosGeneral":$scope.cg,
							"creditosSemestre":$scope.cs,
							"cuentaBanco":$scope.bn,
							"banco":bank,
							"carne":$scope.carne,
							"horas":0,
							"imgPpg":$scope.strPpg,
							"imgPps":$scope.strPps,
							"imgCg":$scope.strCg,
							"imgCs":$scope.strCs,
							"imgCBanco":$scope.strCuenta,
							"imgCed":$scope.strCedula,
							"imgCar":$scope.strCarne,
							"idCurso":"",
							"idProfesor":0,
							"notaCurso":0,
							"imgNotaCurso":"YW55IGNhcm5hbCBwbGVhc3VyZS4=",
							"fecha":localTime,
							"telefono":$scope.telefono,
							"anosTEC":$scope.anTEC,
							"estado":1,
							"otrasAsistenciasDesc": $scope.departamentos,
							"otrasAsistenciasHoras": $scope.horasDepartamento};
							console.log(Data);
							
							$http.post("http://localhost:7010/api/Solicitudes?codigo=S01", Data).
				        	then(function(response) {
				            	$scope.res = response.data;
				            	console.log($scope.res);
				            	alert("Su solicitud ha sido enviada");
				        	});
	        		}	
			    }, 500);
        	};
        $scope.guardarHE = function(){
	        var fileCarne = document.getElementById('imgCarne').files[0];
	        imgToBase64(fileCarne,0);
	        var fileCedula = document.getElementById('imgCedula').files[0];
	        imgToBase64(fileCedula,1);
	        var filePps = document.getElementById('imgPps').files[0];
	        imgToBase64(filePps,2);
	        var filePpg = document.getElementById('imgPpg').files[0];
	        imgToBase64(filePpg,3);
	        var fileCs = document.getElementById('imgCs').files[0];
	        imgToBase64(fileCs,4);
	        var fileCg = document.getElementById('imgCg').files[0];
	        imgToBase64(fileCg,5);
	        var fileCuenta = document.getElementById('imgCuenta').files[0];
	        imgToBase64(fileCuenta,7);
	        var Data = {};
	        setTimeout(function(){
	        		if(errorImg()){
	        			var localTime = new Date();
		        		Data = {"tipoSolicitud": "HE",
							"carrera":1,
		        			"cedula":$scope.cedula,
							"proPonGeneral":$scope.ppg,
							"proPonSemestral":$scope.pps,
							"creditosGeneral":$scope.cg,
							"creditosSemestre":$scope.cs,
							"cuentaBanco":$scope.bn,
							"banco":bank,
							"carne":$scope.carne,
							"horas":0,
							"imgPpg":$scope.strPpg,
							"imgPps":$scope.strPps,
							"imgCg":$scope.strCg,
							"imgCs":$scope.strCs,
							"imgCBanco":$scope.strCuenta,
							"imgCed":$scope.strCedula,
							"imgCar":$scope.strCarne,
							"idCurso":"",
							"idProfesor":0,
							"notaCurso":0,
							"imgNotaCurso":"YW55IGNhcm5hbCBwbGVhc3VyZS4=",
							"fecha":localTime,
							"telefono":$scope.telefono,
							"anosTEC":$scope.anTEC,
							"estado":0,
							"otrasAsistenciasDesc": $scope.departamentos,
							"otrasAsistenciasHoras": $scope.horasDepartamento};
							console.log(Data);
							
							$http.post("http://localhost:7010/api/Solicitudes?codigo=S01", Data).
				        	then(function(response) {
				            	$scope.res = response.data;
				            	console.log($scope.res);
				            	alert("Su borrador ha sido guardado");
				        	});
	        		}	
			    }, 500);
        	};


}]);
