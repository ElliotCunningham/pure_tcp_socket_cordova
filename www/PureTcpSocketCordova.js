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
  sendData: function(data, adress) {
    return new Promise((resolve, reject) => {
      const success = (data) => {
        resolve(data);
      };
      const error = (err) => {
        reject(err);
      };

      exec(success, error, plugName, 'sendDataToAConnexion', [data, adress]);
    });
  },
  getResponse: function(resLength, adress) {
    return new Promise((resolve, reject) => {
      const success = (data) => {
        resolve(data);
      };
      const error = (err) => {
        reject(err);
      };

      exec(success, error, plugName, 'getResponseFromAConnexion', [resLength, adress]);
    });
  },
  closeAndDelete: function(adress) {
    return new Promise((resolve, reject) => {
      const sucess = (data) => {
        resolve(data);
      };
      const error = (err) => {
        reject(err);
      };
      exec(sucess, error, plugName, 'disconnectAndDeleteAConnexion', [adress]);
    });
  }
};

module.exports = PureTcpSocketCordova;
