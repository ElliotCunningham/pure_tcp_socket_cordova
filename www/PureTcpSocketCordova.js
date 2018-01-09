var exec = require('cordova/exec');

const plugName = 'PureTcpSocketCordova'

const PureTcpSocketCordova = {
  connect: function(adress, port) {
    return new Promise((resolve, reject) => {
      const sucess = (data) => {
        resolve(data);
      };

      const error = (err) => {
        reject(err);
      };

      exec(success, error, plugName, 'connect', [adress, port]);
    });
  },
};

module.exports = PureTcpSocketCordova;
