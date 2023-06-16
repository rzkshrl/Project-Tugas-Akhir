Parse.Cloud.define("getScanlogWithPaging", async (request) => {
  const ip = request.params.ip;
  const port = request.params.port;
  const sn = request.params.sn;
  const urlReq = request.params.urlReq;
  const pageNumber = request.params.pageNumber || 0;

  const url = `http://${ip}:${port}${urlReq}?sn=${sn}&page=${pageNumber}&limit=100`;

  const options = {
    url: url,
    headers: {
      'Access-Control-Allow-Origin': '*', // Mengizinkan akses dari semua origin
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE', // Mengizinkan metode HTTP yang diizinkan
      'Access-Control-Allow-Headers': 'Content-Type, Authorization', // Mengizinkan header yang diizinkan
    },
    method: 'POST'
  };

  const response = await Parse.Cloud.httpRequest(options);

  return response.data;
});

Parse.Cloud.define("getDeviceInfo", async (request) => {
  const ip = request.params.ip;
  const port = request.params.port;
  const sn = request.params.sn;
  const urlReq = request.params.urlReq;

  const url = `http://${ip}:${port}${urlReq}?sn=${sn}`;

  const options = {
    url: url,
    headers: {
      'Access-Control-Allow-Origin': '*', // Mengizinkan akses dari semua origin
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE', // Mengizinkan metode HTTP yang diizinkan
      'Access-Control-Allow-Headers': 'Content-Type, Authorization', // Mengizinkan header yang diizinkan
    },
    method: 'POST'
  };

  const response = await Parse.Cloud.httpRequest(options);

  return response.data;
});
