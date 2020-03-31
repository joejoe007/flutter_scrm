class Api {
//  static final String BASE_URL = 'http://www.wanandroid.com/';
  /// 测试接口
  static final String TEST_URL = 'banner/json';


  static final String BASE_URL = 'http://api.s9.9daye.cn/'; /// 测试服

//  static final String BASE_URL =  'http://192.168.1.85:8080/';/// jiang
//  static final String BASE_URL =  'http://192.168.1.24:8080/'; /// wu
//  static final String BASE_URL =  'http://192.168.1.19:8080/'; /// hong
//  static final String BASE_URL =  'http://p15615d775.51mypc.cn/'; /// hong

  /// 版本更新
  static final String VERSION_BASE_URL =  'http://192.168.1.19:8086/'; /// hong

  /// 以下为接口地址



  /// 登录接口
  static final String LOGIN_URL = 's9/scrm/api/v1/login';



  /// 首页营业数据统计
  static final String HOME_STATISTICS = 's9/scrm/api/v1/index-statistics/query';

  /// 余额查询模块
  /// 会员卡列表
  static final String CARDCUSTOMERLIST_URL = 's9/scrm/api/v1/card-customer/list'; /// 暂时不用
  /// 客户会员卡余额
  static final String CARDCUSTOMERBALANCE_URL = 's9/scrm/api/v1/card-customer/balance';
  /// 会员卡详情
  static final String CARDCUSTOMERDETAIL_URL = 's9/scrm/api/v1/card-customer/detail';
  /// 退卡
  static final String REFUNDCUSTOMERCARD_URL = 's9/scrm/api/v1/card-customer/refund';
  /// 会员卡办
  static final String CREATECUSTOMERCARD_URL = 's9/scrm/api/v1/card-customer/create';
  /// 会员卡交易记录
  static final String CONSUMERECORD_URL = 's9/scrm/api/v1/card-customer/consumeRecord';
  /// 会员卡充值/续卡
  static final String CARDCUSTOMERRECHARGE_URL = 's9/scrm/api/v1/card-customer/recharge';
  /// 客户会员卡项目列表
  static final String CONSUMER_CARD_TYPE_URL = 's9/scrm/api/v1/card-customer/infos';


  /// 会员卡卡种
  /// 会员卡卡种列表
  static final String MEMCARDTYPELIST_URL = 's9/scrm/api/v1/cardType/list';
  /// 会员卡卡种增加
  static final String MEMCARDTYPEADD_URL = 's9/scrm/api/v1/cardType/save';
  /// 会员卡卡种详情
  static final String MEMCARDTYPEDETAIL_URL = 's9/scrm/api/v1/cardType/detail';
  /// 会员卡卡种状态修改、删除/上下架
  static final String MEMCARDTYPECHANGESTATUS_URL = 's9/scrm/api/v1/cardType/updateStatus';



  /// 会员卡统计
  /// 会员卡销售统计列表
  static final String MEMCARD_STATISTIC_SALES_LIST_URL = 's9/scrm/api/v1/card-customer-statistics/cardCustomerSaleList';
  /// 会员卡剩余总额统计列表
  static final String MEMCARD_STATISTIC_SALES_MONEY_LIST_URL = 's9/scrm/api/v1/card-customer-statistics/cardCustomerbalanceList';
  /// 会员卡销售额和剩余总额统计
  static final String MEMCARD_STATISTIC_SALES_TOTAL_MONEY_URL = 's9/scrm/api/v1/card-customer-statistics/cardCustomerSaleStatistics';



  /// 挂帐应收
  /// 挂帐应收列表
  static final String ACCOUNT_RECEIVER_LIST = 's9/scrm/api/v1/credit/creditList';
  /// 截止目前未收合计
  static final String ACCOUNT_RECEIVER_NEED_PAY_TOTAL = 's9/scrm/api/v1/credit/needPay';
  /// 挂帐还款某客户欠款列表
  static final String ACCOUNT_RECEIVER_CUSTOMER_LIST = 's9/scrm/api/v1/credit/needPayList/';
  /// 销帐
  static final String ACCOUNT_RECEIVER_PAY_BACK = 's9/scrm/api/v1/credit/payback';




  /// 项目模块
  /// 项目列表
  static final String SERVICELIST_URL = 's9/scrm/api/v1/service_item/list';
  /// 项目添加
  static final String SRRVICEADD_URL = 's9/scrm/api/v1/service_item/add';
  /// 项目分类列表
  static final String SERVICECATEGORYLIST_URL = 's9/scrm/api/v1/serviceCategory/list';
  /// 项目详情
  static final String SERVICELISTDETAIL_URL = 's9/scrm/api/v1/service_item/detail';
  /// 项目更新
  static final String SERVICEDETAILUPDATE_URL = 's9/scrm/api/v1/service_item/update';
  /// 项目删除
  static final String SERVICEDELETE_URL = 's9/scrm/api/v1/service_item/delete';



  /// 门店支出
  /// 门店支出列表
  static final String STORECOSTLISTURL = 's9/scrm/api/v1/storeCost/list';
  /// 门店支出删除
  static final String STORECOSTDELETE_URL = 's9/scrm/api/v1/storeCost/delete';
  /// 新增门店支出
  static final String STORECOSTADD_URL = '/s9/scrm/api/v1/storeCost/add';


  /// 员工信息
  /// 员工列表
  static final String STOREUSERLIST_URL = 's9/scrm/api/v1/storeUser/list';
  /// 新增员工
  static final String STOREUSERADD_URL = 's9/scrm/api/v1/storeUser/add';
  /// 修改员工
  static final String STOREUSERUPDATE_URL = 's9/scrm/api/v1/storeUser/update';
  /// 删除员工
  static final String STOREUSERDELETE_URL = 's9/scrm/api/v1/storeUser/delete';



  /// 角色
  /// 角色列表
  static final String SYSROLELIST_URL = 's9/scrm/api/v1/role/list';


  /// 客户消费统计
  /// 客户消费累计
  static final String CUSTOMER_CONSTOMER_TOTAL = 's9/scrm/api/v1/customer-consume/total/';



  /// 角色和权限
  /// 菜单列表
  static final String SYSMENULIST_URL = 's9/scrm/api/v1/new/sysMenu/list';
  /// 新增
  static final String SYSRELATIONADD_URL = 's9/scrm/api/v1/new/sysRelation/app/addList';
  /// 角色菜单关系
  static final String SYSRELATIONLIST_URL = 's9/scrm/api/v1/new/sysRelation/list';




  /// 客户关怀设置
  /// 客户关怀设置列表
  static final String SCRMALARMSETTING_URL = 's9/scrm/api/v1/scrmAlarmSetting/list';
  /// 修改客户关怀设置
  static final String UPDATESCRMALARMSETTING_URL = 's9/scrm/api/v1/scrmAlarmSetting/update';
  /// 开启关闭设置
  static final String UPDATEALLSCRMALARMSETTING_URL = 's9/scrm/api/v1/scrmAlarmSetting/updateAll';



  /// 客户关怀
  /// 客户关怀列表
  static final String SCRMALARMHISTORYLIST_URL = 's9/scrm/api/v1/scrmAlarmHistory/list4pc';
  /// 发送客户关怀
  static final String SCRMALARMHISTORYSEND_URL = 's9/scrm/api/v1/scrmAlarmHistory/sendList';


  /// 车型车系
  /// 获取车辆品牌
  static final String CAR_BRAND_LIST = 's9/scrm/api/v1/carBrand/list4App';
  /// 根据车品牌id获取车系
  static final String CAR_SERIES_LIST = 's9/scrm/api/v1/carBrand/listSeries/';
  /// 根据车系id获取型号
  static final String CAR_MODELS = 's9/scrm/api/v1/carBrand/listModels/';


  /// 客户管理模块
  /// 客户列表
  static final String CUSTOMER_LIST = 's9/scrm/api/v1/customer/list';
  /// 检验手机号是否存在
  static final String CUSTOMER_MOBILE_EXIST = 's9/scrm/api/v1/customer/mobileExist';
  /// 客户数量
  static final String CUSTOMER_NUM_INFO = 's9/scrm/api/v1/customer/customerCount';
  /// 客户详情
  /// s9/scrm/api/v1/customer/detail/{id}
  static final String CUSTOMER_DETAIL = 's9/scrm/api/v1/customer/detail/';
  /// 新增/更新客户信息
  static final String CUSTOMER_ADD_UPDATE_INFO = 's9/scrm/api/v1/customer/save';

  /// 车辆管理
  /// 新增/修改车辆信息
  static final String CAR_ADD_UPDATE_INFO  = 's9/scrm/api/v1/car/save';
  /// 车牌号获取车辆详情
  static final String CAR_INFO_BY_CAR_NUM = 's9/scrm/api/v1/car/findByCarNo/';
  /// 车辆列表
  static final String CAR_INFO_LIST = 's9/scrm/api/v1/car/list';


  /// 订单
  /// 新增订单
  static final String ADD_ORDER = 's9/scrm/api/v1/order/add';
  /// 修改订单
  static final String UPDATE_ORDER = 's9/scrm/api/v1/order/update';
  /// 获取订单列表
  static final String ORDER_LIST = 's9/scrm/api/v1/order/list';
  /// 根据订单ID查询订单基础数据(不包含订单项数据)
  static final String ORDER_Detail = 's9/scrm/api/v1/order/detail/';
  /// 撤单
  static final String ORDER_CANCEL = 's9/scrm/api/v1/order/cancelOrder/';
  /// 消费记录
  static final String ORDER_RECENT_ORDERS = 's9/scrm/api/v1/order/recentOrders/';

  /// 订单结算
  /// 新增订单结算
  static final String ADD_ORDER_SETTLEMENT = 's9/scrm/api/v1/orderSettlement/add';
  /// 根据订单ID获得结算数据
  static final String ORDER_SETTLEMENT_DETAIL = 's9/scrm/api/v1/orderSettlement/detailByOrderId/';
  /// 预付
  static final String ORDER_SETTLEMENT_PREPAY = 's9/scrm/api/v1/orderSettlement/prepay';

  /// 订单详情
  /// 根据订单ID查询关联的订单项信息(不包含订单基础数据)
  static final String ORDER_ITEM_INFO = 's9/scrm/api/v1/orderDetail/getOrderItemsByOrderId/';

  /// 项目
  /// 项目列表
  static final String PROJECT_LIST = 's9/scrm/api/v1/service_item/list';

  /// 营业汇总
  /// 营业汇总总界面
  static final String FINANCE_DETAIL = 's9/scrm/api/v1/statistics/app/index';
  /// 营业额明细总数和销量
  static final String FINANCE_SUM_DETAIL = 's9/scrm/api/v1/statistics/bizDetail/tab';
  /// 营业额明细界面
  static final String FINANCE_SUM_LIST = 's9/scrm/api/v1/statistics/pc/bizDetail';
  /// 营业汇总实收总数和销量
  static final String FINANCE_INCOME_DETAIL = 's9/scrm/api/v1/statistics/incomeDetail/tab';
  /// 营业汇总实收明细
  static final String FINANCE_INCOME_LIST = 's9/scrm/api/v1/statistics/pc/incomeDetail';

  /// 退单
  /// 新增退单
  static final String REFUND_ORDERS_ADD = 's9/scrm/api/v1/refundOrders/add';
  /// 退单详情
  static final String REFUND_ORDERS_DETAIL = 's9/scrm/api/v1/refundOrders/detail/';


  /// app版本
  static final String APP_VERSION_INFO = 's9/scrm/api/v1/admin/app/getLastVersion';

  /// vin
  /// vin阿里云接口
  static final String VIM_IMAGE_URL = 'https://vin.market.alicloudapi.com/api/predict/ocr_vin';
  /// vin车辆信息
  static final String VIN_CAR_INFO_URL = 's9/scrm/api/v1/vincode/doQueryCarInfoByVinCode';
}


class ElectricityApi {

  static final String ElectricityBaseURL = 'http://m.ecom.test.9daye.cn/';

  /// 订单相关
  static final String WaitPayURL = '${ElectricityBaseURL}#/order/list/0';
  static final String WaitSendGoodsURL = '${ElectricityBaseURL}#/order/list/1';
  static final String WaitGetGoodsURL = '${ElectricityBaseURL}#/order/list/2';
  static final String OrdersSalesReturn = '${ElectricityBaseURL}#/order/SalesReturn/';


}