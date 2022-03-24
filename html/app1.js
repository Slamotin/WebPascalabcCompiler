const WebSocket = require('ws');
const wsServer = new WebSocket.Server({ port: 9000, 'Access-Control-Allow-Origin': "*" });

wsServer.on('connection', onConnect);

function onConnect(wsClient) {
    console.log('Новый пользователь');
    wsClient.send('Привет');

    wsClient.on('message', function(message) {
        console.log(message);
        try {
            const jsonMessage = JSON.parse(message);
            switch (jsonMessage.action) {
                case 'ECHO':
                    wsClient.send(jsonMessage.data);
                    break;
                case 'PING':
                    setTimeout(function() {
                        wsClient.send('PONG');
                    }, 2000);
                    break;
                default:
		    const { exec } = require("child_process");
		    var x = new String(jsonMessage.data);
		    console.log(x.toString());
		    exec("echo " + '"'+ x.toString() +'"'+ " > p.pas", (error, stdout, stderr) => {
    			if (error) {
    			    console.log(`error: ${error.message}`);
    			    
			}
			if (stderr) {
    			    console.log(`stderr: ${stderr}`);
    			    
			}
			console.log(`stdout: ${stdout}`);
		    });
		    exec("mono /opt/pabcnetc/pabcnetc.exe /var/www/html/p.pas /var/www/html/p.exe", (error, stdout, stderr) => {
    			if (error) {
    			    console.log(`error: ${error.message}`);
    			    console.log(`stdout: ${stdout}`);
			    wsClient.send(stdout.slice(333));
			}
			if (stderr) {
    			    console.log(`stderr: ${stderr}`);
    			    
			}
			if (!error) {
			    exec("mono /var/www/html/p.exe", (error, stdout, stderr) => {
    			    if (error) {
    				console.log(`error: ${error.message}`);
    			    
			    }
			    if (stderr) {
    				console.log(`stderr: ${stderr}`);
    			    
			    }
			    console.log(`stdout: ${stdout}`);
			    wsClient.send(stdout);
			    });
			}
			
		    });
                    break;
            }
        } catch (error) {
            console.log('Ошибка', error);
        }
	const { exec } = require("child_process");

	
    });
    wsClient.on('close', function() {
        console.log('Пользователь отключился');
    });
}


console.log('Сервер запущен на 9000 порту');