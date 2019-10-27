const serviceUrl='https://douban.uieee.com/v2';
const servicePath={
  // 通过ISBN获取图书信息
  'getBookInfoByISBN':serviceUrl+'/book/isbn/',

  // 通过条形码获取商品信息
  'getProductMessage':serviceUrl+'/api/barcode/goods/details',
};