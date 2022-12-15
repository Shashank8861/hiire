import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_swipeable_stack.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';

class SwipeWidget extends StatefulWidget {
  const SwipeWidget({Key? key}) : super(key: key);

  @override
  _SwipeWidgetState createState() => _SwipeWidgetState();
}

class _SwipeWidgetState extends State<SwipeWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late SwipeableCardSectionController swipeableStackController;

  @override
  void initState() {
    super.initState();
    swipeableStackController = SwipeableCardSectionController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).celadon,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).turquoise,
        automaticallyImplyLeading: false,
        title: Text(
          'Opportunity',
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Urbanist',
                color: FlutterFlowTheme.of(context).cultured,
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: FaIcon(
              FontAwesomeIcons.coins,
              color: Color(0xFFE1F149),
              size: 30,
            ),
            onPressed: () async {
              context.pushNamed('wallet');
            },
          ),
          Align(
            alignment: AlignmentDirectional(0, 0.2),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
              child: AuthUserStreamWidget(
                child: Text(
                  valueOrDefault(currentUserDocument?.coins, 0).toString(),
                  style: FlutterFlowTheme.of(context).bodyText1.override(
                        fontFamily: 'Urbanist',
                        color: FlutterFlowTheme.of(context).cultured,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ),
        ],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: StreamBuilder<UsersRecord>(
            stream: UsersRecord.getDocument(currentUserReference!),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      color: FlutterFlowTheme.of(context).primaryColor,
                    ),
                  ),
                );
              }
              final columnUsersRecord = snapshot.data!;
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (FFAppState().visibleSuperlike == true)
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (valueOrDefault(currentUserDocument?.coins, 0) >= 40)
                          AuthUserStreamWidget(
                            child: Text(
                              'SuperLike Disabled',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Urbanist',
                                    color:
                                        FlutterFlowTheme.of(context).redApple,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30,
                          borderWidth: 1,
                          buttonSize: 60,
                          icon: Icon(
                            Icons.close,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 30,
                          ),
                          onPressed: () async {
                            setState(() {
                              FFAppState().visibleSuperlike = false;
                            });
                          },
                        ),
                      ],
                    ),
                  if (FFAppState().visibleLike == true)
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (valueOrDefault(currentUserDocument?.coins, 0) >=
                            160)
                          AuthUserStreamWidget(
                            child: Text(
                              'Swipe Right Disabled',
                              style: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Urbanist',
                                    color:
                                        FlutterFlowTheme.of(context).redApple,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30,
                          borderWidth: 1,
                          buttonSize: 60,
                          icon: Icon(
                            Icons.close,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 30,
                          ),
                          onPressed: () async {
                            setState(() {
                              FFAppState().visibleLike = false;
                            });
                          },
                        ),
                      ],
                    ),
                  Expanded(
                    child: StreamBuilder<List<JobsRecord>>(
                      stream: queryJobsRecord(
                        queryBuilder: (jobsRecord) => jobsRecord.where(
                            'creater_user_id',
                            isNotEqualTo: currentUserUid),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                              ),
                            ),
                          );
                        }
                        List<JobsRecord> swipeableStackJobsRecordList =
                            snapshot.data!;
                        return FlutterFlowSwipeableStack(
                          topCardHeightFraction: 0.72,
                          middleCardHeightFraction: 0.68,
                          bottomCardHeightFraction: 0.75,
                          topCardWidthFraction: 0.9,
                          middleCardWidthFraction: 0.85,
                          bottomCardWidthFraction: 0.8,
                          onSwipeFn: (index) async {
                            final jobsUpdateData = {
                              'interacted':
                                  FieldValue.arrayUnion([currentUserUid]),
                            };
                            await swipeableStackJobsRecordList[index]!
                                .reference
                                .update(jobsUpdateData);
                          },
                          onLeftSwipe: (index) {},
                          onRightSwipe: (index) async {
                            if (valueOrDefault(currentUserDocument?.coins, 0) <
                                40) {
                              var confirmDialogResponse =
                                  await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('Insuffiicient coins'),
                                            content: Text(
                                                'Minimum 40 coins are required for this operation.  Do you want to add more coins?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, true),
                                                child: Text('Yes'),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                      false;
                              if (confirmDialogResponse) {
                                context.pushNamed(
                                  'wallet',
                                  extra: <String, dynamic>{
                                    kTransitionInfoKey: TransitionInfo(
                                      hasTransition: true,
                                      transitionType: PageTransitionType.fade,
                                    ),
                                  },
                                );
                              } else {
                                return;
                              }
                            } else {
                              final interestedCreateData =
                                  createInterestedRecordData(
                                jobId:
                                    swipeableStackJobsRecordList[index]!.jobId,
                                createrId: swipeableStackJobsRecordList[index]!
                                    .createrUserId,
                                accepterId: currentUserUid,
                                jobName: swipeableStackJobsRecordList[index]!
                                    .postTitle,
                                budget:
                                    swipeableStackJobsRecordList[index]!.budget,
                                category: swipeableStackJobsRecordList[index]!
                                    .postCategory,
                                accepterName: currentUserDisplayName,
                                accepterDp: currentUserPhoto,
                                accepterRef: currentUserReference,
                                jobRef: swipeableStackJobsRecordList[index]!
                                    .reference,
                              );
                              await InterestedRecord.collection
                                  .doc()
                                  .set(interestedCreateData);

                              final usersUpdateData = {
                                'coins': FieldValue.increment(-(40)),
                              };
                              await currentUserReference!
                                  .update(usersUpdateData);
                              return;
                            }
                          },
                          onUpSwipe: (index) async {
                            if (valueOrDefault(currentUserDocument?.coins, 0) >=
                                160) {
                              final usersUpdateData = {
                                'coins': FieldValue.increment(-(160)),
                              };
                              await currentUserReference!
                                  .update(usersUpdateData);

                              context.pushNamed(
                                'chatDetails',
                                queryParams: {
                                  'chatUser': serializeParam(
                                    columnUsersRecord,
                                    ParamType.Document,
                                  ),
                                }.withoutNulls,
                                extra: <String, dynamic>{
                                  'chatUser': columnUsersRecord,
                                },
                              );

                              return;
                            } else {
                              var confirmDialogResponse =
                                  await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('Insuffiicient coins'),
                                            content: Text(
                                                'Minimum 160 coins are required for this operation.  Do you want to add more coins?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, true),
                                                child: Text('Yes'),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                      false;
                              if (confirmDialogResponse) {
                                context.pushNamed('wallet');

                                return;
                              } else {
                                return;
                              }
                            }
                          },
                          onDownSwipe: (index) {},
                          itemBuilder: (context, swipeableStackIndex) {
                            final swipeableStackJobsRecord =
                                swipeableStackJobsRecordList[
                                    swipeableStackIndex];
                            return Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Color(0xFFF5F5F5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.network(
                                      'https://t3.ftcdn.net/jpg/02/70/35/00/360_F_270350073_WO6yQAdptEnAhYKM5GuA9035wbRnVJSr.jpg',
                                    ).image,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16, 12, 16, 8),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  swipeableStackJobsRecord
                                                      .name!,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Urbanist',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .cultured,
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(16, 0, 16, 8),
                                                child: Text(
                                                  swipeableStackJobsRecord
                                                      .place!,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Urbanist',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .cultured,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        color: Color(0xC0A84D4D),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Card(
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              color: Color(0xCDA36969),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        'Category',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Urbanist',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .cultured,
                                                                  fontSize: 20,
                                                                ),
                                                      ),
                                                      Text(
                                                        'Topic',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Urbanist',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .lineGray,
                                                                  fontSize: 20,
                                                                ),
                                                      ),
                                                      Text(
                                                        'Budget',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Urbanist',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .lineGray,
                                                                  fontSize: 20,
                                                                ),
                                                      ),
                                                      Text(
                                                        'Duration',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Urbanist',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .cultured,
                                                                  fontSize: 20,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        swipeableStackJobsRecord
                                                            .postCategory!,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Urbanist',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .lineGray,
                                                                  fontSize: 20,
                                                                ),
                                                      ),
                                                      Text(
                                                        swipeableStackJobsRecord
                                                            .postTitle!,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Urbanist',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .cultured,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                      ),
                                                      Text(
                                                        swipeableStackJobsRecord
                                                            .budget!,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Urbanist',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .lineGray,
                                                                  fontSize: 20,
                                                                ),
                                                      ),
                                                      Text(
                                                        swipeableStackJobsRecord
                                                            .duration!,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Urbanist',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .lineGray,
                                                                  fontSize: 20,
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            FFButtonWidget(
                                              onPressed: () async {
                                                context.pushNamed(
                                                  'jobDetails',
                                                  queryParams: {
                                                    'username': serializeParam(
                                                      swipeableStackJobsRecord
                                                          .name,
                                                      ParamType.String,
                                                    ),
                                                    'country': serializeParam(
                                                      swipeableStackJobsRecord
                                                          .place,
                                                      ParamType.String,
                                                    ),
                                                    'description':
                                                        serializeParam(
                                                      swipeableStackJobsRecord
                                                          .postDescription,
                                                      ParamType.String,
                                                    ),
                                                    'jobTitle': serializeParam(
                                                      swipeableStackJobsRecord
                                                          .postTitle,
                                                      ParamType.String,
                                                    ),
                                                    'category': serializeParam(
                                                      swipeableStackJobsRecord
                                                          .postCategory,
                                                      ParamType.String,
                                                    ),
                                                    'budget': serializeParam(
                                                      swipeableStackJobsRecord
                                                          .budget,
                                                      ParamType.String,
                                                    ),
                                                    'duration': serializeParam(
                                                      swipeableStackJobsRecord
                                                          .duration,
                                                      ParamType.String,
                                                    ),
                                                    'jobname': serializeParam(
                                                      swipeableStackJobsRecord
                                                          .postTitle,
                                                      ParamType.String,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              },
                                              text: 'View More',
                                              options: FFButtonOptions(
                                                width: 130,
                                                height: 40,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryColor,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle2
                                                        .override(
                                                          fontFamily:
                                                              'Urbanist',
                                                          color: Colors.white,
                                                        ),
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: swipeableStackJobsRecordList.length,
                          controller: swipeableStackController,
                          enableSwipeUp: true,
                          enableSwipeDown: false,
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 90,
                        icon: FaIcon(
                          FontAwesomeIcons.arrowCircleLeft,
                          color: FlutterFlowTheme.of(context).cultured,
                          size: 60,
                        ),
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text('Swipe left to reject the job'),
                                content: Text(
                                    'If you are not interested in this job, swipe left on the job card'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext),
                                    child: Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 110,
                        icon: Icon(
                          Icons.arrow_circle_up_outlined,
                          color: FlutterFlowTheme.of(context).cultured,
                          size: 90,
                        ),
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text(
                                    'Swipe up to directly connect with the job creator'),
                                content:
                                    Text('This action will cost 160 coins'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext),
                                    child: Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 90,
                        icon: FaIcon(
                          FontAwesomeIcons.arrowCircleRight,
                          color: FlutterFlowTheme.of(context).cultured,
                          size: 60,
                        ),
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text('Swipe right to send  a request'),
                                content: Text(
                                    'If you are interested in this job, swipe right on the job card '),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext),
                                    child: Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
