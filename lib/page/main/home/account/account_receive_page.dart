import 'package:flutter/material.dart';
import 'package:flutter_project1/common/app_color.dart';
import 'package:flutter_project1/common/app_image.dart';
import 'package:flutter_project1/model/account_receiver_model.dart';
import 'package:flutter_project1/page/main/home/account/account_write_off_page.dart';
import 'package:flutter_project1/util/navigator_util.dart';
import 'package:flutter_project1/util/screen.dart';
import 'package:flutter_project1/util/string_util.dart';
import 'package:flutter_project1/viewmodel/account_receive_vmodel.dart';
import 'package:flutter_project1/widget/automake_searchbar_widget.dart';
import 'package:flutter_project1/widget/common_space.dart';
import 'package:flutter_project1/widget/common_style.dart';
import 'package:flutter_project1/widget/loading_container.dart';
import 'package:flutter_project1/widget/my_app_bar_view.dart';
import 'package:quiver/strings.dart';

class AccountReceivePage extends StatefulWidget {
  @override
  _AccountReceivePageState createState() => _AccountReceivePageState();
}

class _AccountReceivePageState extends State<AccountReceivePage> {
  AccountReceiveVModel _accountReceiveVModel = AccountReceiveVModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: MyAppBarView(
          title: '挂帐应收',
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                  color: AppColors.color_ffffff,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: AutoMakeSearchBar(
                      fieldCallBack: (content) {
                        _accountReceiveVModel.setKey(content);
                      },
                      hintText: '请输入关键词搜索',
                    ),
                  )),
              Expanded(
                child: LoadingContainer<AccountReceiveVModel>(
                    refreshType: RefreshType.withwidget,
                    onModelReady: (model) {
                      _accountReceiveVModel = model;
                    },
                    successChild: (model) {
                      return ListView.separated(
                        itemCount: model.list.length,
                        itemBuilder: (BuildContext context, int index) {
                          AccountNeedListItemModel item = model.list[index];
                          return userAccountItem(context, item);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return DividerUtil.HDivider(Screen.h(8));
                        },
                      );
                    },
                    outRefreshChild: (model, easyRefresh) {
                      return Container(
                        color: AppColors.color_f4f4f4,
                        child: Column(
                          children: <Widget>[
                            Container(
                              color: AppColors.color_ffcfcf,
                              height: Screen.h(35),
                              width: Screen.w(),
                              alignment: Alignment.center,
                              child: Text(
                                '总欠款 ' + '¥' + StringUtil.checkEmpty(_accountReceiveVModel?.accountTotalModel?.needPayMoney?.toString(), '0'),
                                style: TextStyle(
                                  color: AppColors.color_ff3c48,
                                  fontSize: Screen.sp(15),
                                ),
                              ),
                            ),
                            Expanded(
                              child: easyRefresh,
                            )
                          ],
                        ),
                      );
                    },
                    model: AccountReceiveVModel()),
              )
            ],
          ),
        ));
  }

  Widget userAccountItem(
      BuildContext context, AccountNeedListItemModel item) {
    return Container(
      padding: EdgeInsets.all(Screen.w(12)),
      decoration: BoxDecoration(
        color: AppColors.color_ffffff,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        children: <Widget>[
          Container(
              height: Screen.w(57),
              width: Screen.w(57),
              child: CircleAvatar(
                  child: Text(
                    StringUtil.checkEmpty(item?.customerName?.toString(), '未').substring(0, 1),
                    style: TextStyle(
                        fontSize: Screen.sp(20),
                        color: AppColors.color_ffffff,
                        fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: AppColors.color_fbbe50)),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(Screen.w(12), 0, Screen.w(12), 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(StringUtil.checkEmpty(item?.customerName?.toString())+ ' ' + StringUtil.checkEmpty(item?.mobile?.toString()),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: CStyle.style(AppColors.color_212121, 16),
                  ),
                  DividerUtil.HDivider(Screen.h(4)),
                  Text(
                    StringUtil.checkEmpty(item?.carNo?.toString()),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: CStyle.style(AppColors.color_999999, 14),
                  ),
                  DividerUtil.HDivider(Screen.h(4)),
                  Text('¥' + StringUtil.checkEmpty(item.creditMoneyTotal.toString(), '0'),
                    style: CStyle.style(AppColors.color_ff3c48, 16),
                  ),
                ],
              ),
            ),
            flex: 1,
          ),
          new Container(
              padding: EdgeInsets.fromLTRB(Screen.w(20), 0, Screen.w(20), 0),
              height: Screen.h(25),
              child: VerticalDivider(color: AppColors.color_999999)),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  AppImages.iconAccountOff,
                  fit: BoxFit.cover,
                  width: Screen.w(26),
                  height: Screen.h(32),
                ),
                DividerUtil.HDivider(Screen.h(8)),
                Text(
                  '销账',
                  style: CStyle.style(AppColors.color_212121, 14),
                ),
              ],
            )),
            onTap: () {
              NavigatorUtil.push(
                  context,
                  new AccountWriteOffPage(
                    customerId: item.customerId,
                    customerMoney: item.creditMoneyTotal,
                  ));
            },
          ),
          DividerUtil.VDivider(Screen.w(12)),
        ],
      ),
    );
  }
}

class EnterTextView extends StatefulWidget {
  final String title;
  final String hintText;

  const EnterTextView({Key key, this.title, this.hintText}) : super(key: key);

  @override
  _EnterTextViewState createState() => _EnterTextViewState();
}

class _EnterTextViewState extends State<EnterTextView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          new Text(widget.title + '：'),
          new Expanded(
              child: new TextField(
            decoration: new InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
            ),
          )),
        ],
      ),
    );
  }
}
