// ignore_for_file: use_build_context_synchronously

import 'package:capstone/components/utils.dart';
import 'package:capstone/ans/ansAddPage.dart';
import 'package:capstone/ans/ansEditPage.dart';
import 'package:capstone/main.dart';
import 'package:capstone/qu/quEditPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:capstone/ans/ansDetailController.dart';

class AnsDetailPage extends StatelessWidget {
  final String articleId;

  AnsDetailPage({super.key, required this.articleId});
  final CollectionReference articles =
      FirebaseFirestore.instance.collection('articles');

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AnsDetailController(articleId));
    return Scaffold(
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 5,
              offset: Offset.zero,
            ),
          ],
          image: const DecorationImage(
              image: AssetImage('assets/images/background_1.png'),
              fit: BoxFit.cover,
              opacity: 0.9),
        ),
        width: MediaQuery.of(context).size.width / 4 + 10,
        height: 35,
        child: FloatingActionButton.extended(
          onPressed: () {
            Get.to(
                fullscreenDialog: true, () => AnsAddPage(articleId: articleId));
          },
          label: const Row(
            children: [
              Icon(
                Icons.add,
                color: Colors.white,
                size: 17,
              ),
              SizedBox(width: 4),
              Text(
                '답변하기',
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat, // 위치 중앙 하단 설정
      appBar: AppBar(
        title: const Text('상세보기'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() {
            if (controller.articleData.value == null) {
              return const Center(child: CircularProgressIndicator());
            }

            var articleData = controller.articleData.value!;
            var answersData = controller.answersData;

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset.zero,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Q.',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 106, 0, 0),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(articleData['category'],
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(158, 106, 0, 0),
                                  )),
                              Visibility(
                                visible: articleData['title'].isNotEmpty,
                                child: Text(
                                  articleData['title'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.only(top: 5, right: 5),
                                    width: 25,
                                    child: const CircleAvatar(
                                      backgroundColor: Color(0xffE6E6E6),
                                    ),
                                  ),
                                  Text(
                                      '${articleData['user']['name']}﹒${formatTimestamp(articleData['created_at'])}\n${articleData['user']['university']} ${articleData['user']['major']}',
                                      style: const TextStyle(
                                        fontSize: 9,
                                      )),
                                ],
                              ),
                              Text(
                                articleData['content'],
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              if (articleData['user']['uid'] == appUser?.uid)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                fullscreenDialog: true,
                                                builder: (context) =>
                                                    QuEditPage(
                                                      articleId: articleId,
                                                    )));
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        width: 40,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          border: Border.all(
                                            color: Colors.grey[300]!,
                                          ),
                                        ),
                                        child: const Text(
                                          '수정',
                                          style: TextStyle(fontSize: 11),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.quDelete(articleId);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 10, left: 5),
                                        width: 40,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          border: Border.all(
                                            color: Colors.grey[300]!,
                                          ),
                                        ),
                                        child: const Text(
                                          '삭제',
                                          style: TextStyle(fontSize: 11),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ]),
                      ),
                      Divider(
                        color: Colors.black.withOpacity(0.1),
                        height: 0,
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.updateLike(articleId);
                                  },
                                  child: Visibility(
                                    visible: controller
                                        .articleData.value!['likes_uid']
                                        .contains(appUser?.uid),
                                    replacement: Icon(
                                      Icons.favorite_border_outlined,
                                      size: 17,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    child: Icon(
                                      Icons.favorite,
                                      size: 17,
                                      color: Colors.red.withOpacity(0.8),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  '${articleData['like'] ?? 0}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Icon(
                                  Icons.mode_comment_outlined,
                                  size: 17,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  '${answersData.length}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.ios_share,
                              size: 17,
                              color: Colors.black.withOpacity(0.7),
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.black.withOpacity(0.1),
                        height: 0,
                        thickness: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
// ---------------------------------------------답변-------------------------------------------------------------------------------------
                      for (var answer in answersData)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 30,
                              child: CircleAvatar(
                                backgroundColor: Color(0xffE6E6E6),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 20),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: answer['is_adopted'] == true
                                      ? const Color.fromARGB(40, 157, 0, 0)
                                      : Colors.grey[50],
                                  border: Border.all(
                                    color: Colors.grey[100]!,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Visibility(
                                      visible: appUser?.uid ==
                                              articleData['user']['uid'] &&
                                          appUser?.uid !=
                                              answer['user']['uid'] &&
                                          articleData['is_adopted'] == false,
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 5),
                                        padding: const EdgeInsets.all(5),
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              20, 157, 0, 0),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.is_adopted(
                                                articleId, answer['id']);
                                          },
                                          child: const Text(
                                            '채택하기',
                                            style: TextStyle(
                                              fontSize: 10,
                                              // fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 157, 0, 0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible:
                                          articleData['is_adopted'] == true &&
                                              answer['is_adopted'] == true,
                                      child: Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 10),
                                        // padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          // color: Colors.red[100],
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: const Row(
                                          children: [
                                            Icon(
                                              Icons.check_circle,
                                              size: 15,
                                              color: Color.fromARGB(
                                                  255, 157, 0, 0),
                                            ),
                                            SizedBox(width: 3),
                                            Text(
                                              '채택된 답변입니다.',
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.normal,
                                                  color: Color.fromARGB(
                                                      255, 157, 0, 0)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${answer['user']['name']}',
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Visibility(
                                          visible: answer['user']['uid'] ==
                                              appUser?.uid,
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(AnsEditPage(
                                                    articleId: articleId,
                                                    answerId: answer['id'],
                                                  ));
                                                },
                                                child: Container(
                                                  width: 30,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[100],
                                                    border: Border.all(
                                                      color: Colors.grey[300]!,
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    '수정',
                                                    style:
                                                        TextStyle(fontSize: 9),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              GestureDetector(
                                                onTap: () {
                                                  controller.ansDelete(
                                                      articleId, answer['id']);
                                                },
                                                child: Container(
                                                  width: 30,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[100],
                                                    border: Border.all(
                                                      color: Colors.grey[300]!,
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    '삭제',
                                                    style:
                                                        TextStyle(fontSize: 9),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      formatTimestamp(answer['created_at']),
                                      style: const TextStyle(fontSize: 9),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      answer['content'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
