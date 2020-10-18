const net = require('net');

function sendMsg(msg) {
	const json = JSON.stringify(msg);
	const sock = new net.Socket();

	sock.on('close', () => {});
	sock.on('connect', () => {
		sock.write(json, () => sock.destroy());
	});

	sock.connect({
		port: 39999,
		host: '127.0.0.1',
	});
}

module.exports = {
	sendMsg,
};
