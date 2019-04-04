var IPFS = require('ipfs-http-client')
var ipfs = IPFS({ host: 'ipfs.infura.io', port: '5001', protocol: 'https' })

export default ipfs

