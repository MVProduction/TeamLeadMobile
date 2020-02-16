import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:team_lead/common/stores/team_lead_app_store.dart';

/// Виджет поиска постов
class SearchWidget extends StatelessWidget {
  /// Создаёт виджет
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom:
                  BorderSide(color: Colors.grey, style: BorderStyle.solid))),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 60,
            child: TextField(
              decoration: InputDecoration(hintText: "Текст поиска"),
            ),
          ),
          Container(
            height: 40,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: RaisedButton.icon(
                      color: Colors.green.shade700,
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      label: Text(
                        "Найти",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                RaisedButton.icon(
                    color: Colors.red.shade700,
                    onPressed: () {
                      teamLeadAppStore.postListPageStore
                          .setNeedShowSearchPanel(false);
                    },
                    icon: Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Отмена",
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
