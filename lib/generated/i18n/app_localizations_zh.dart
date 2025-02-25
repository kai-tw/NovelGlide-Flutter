// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get generalEmpty => '空空如也';

  @override
  String get generalLoading => '載入中';

  @override
  String get generalSubmit => '送出';

  @override
  String get generalSelect => '選擇';

  @override
  String get generalDelete => '刪除';

  @override
  String get generalCancel => '取消';

  @override
  String get generalClose => '關閉';

  @override
  String get generalYes => '是';

  @override
  String get generalNo => '否';

  @override
  String get generalSave => '儲存';

  @override
  String get generalDone => '完成';

  @override
  String get generalSelectAll => '全選';

  @override
  String get generalDeselectAll => '取消全選';

  @override
  String get generalDragHereToDelete => '拖曳到此處即可將其刪除';

  @override
  String get generalAdd => '新增';

  @override
  String get generalName => '名稱';

  @override
  String get generalReset => '重設';

  @override
  String get generalRefreshAndTryAgain => '請重新整理後再試一次。';

  @override
  String get bookshelfTitle => '書櫃';

  @override
  String get bookshelfSortName => '書名';

  @override
  String get bookshelfSortLastModified => '新增時間';

  @override
  String get bookshelfNoBook => '沒有書籍';

  @override
  String get bookshelfBookNotExist => '這本書不存在';

  @override
  String get bookshelfAccessibilityCheckbox => '點擊以選擇或取消選擇這本書';

  @override
  String get deleteBookSuccessfully => '刪除書籍成功';

  @override
  String get deleteBookFailed => '刪除書籍失敗';

  @override
  String get addBookFailed => '新增書籍失敗';

  @override
  String get addBookDuplicated => '這本書已經存在。';

  @override
  String get addToCollection => '新增至收藏';

  @override
  String get collectionTitle => '收藏';

  @override
  String get collectionNoCollection => '沒有收藏';

  @override
  String get collectionAddBtn => '新增收藏';

  @override
  String get collectionAddTitle => '新增收藏';

  @override
  String get collectionName => '收藏名稱';

  @override
  String get collectionAddSuccess => '新增收藏成功。';

  @override
  String collectionDelete(Object number) {
    return '刪除 $number 個已選擇的收藏';
  }

  @override
  String get collectionAddToCollections => '新增至收藏';

  @override
  String get collectionSaved => '收藏已儲存';

  @override
  String get collectionAddEmpty => '不能為空。';

  @override
  String get bookmarkListTitle => '書籤';

  @override
  String get bookmarkListNoBookmark => '沒有儲存的書籤';

  @override
  String get bookmarkListSortName => '書籤名稱';

  @override
  String get bookmarkListSortSavedTime => '儲存時間';

  @override
  String bookmarkListDeleteNumberOfSelectedBookmarks(Object number) {
    return '刪除 $number 個已選擇的書籤';
  }

  @override
  String get bookmarkListAccessibilitySelectItem => '選擇或取消選擇此書籤';

  @override
  String get bookmarkListAccessibilityItem => '一個書籤';

  @override
  String get bookmarkListAccessibilityOnTap => '點擊以從書籤位置繼續閱讀';

  @override
  String get bookmarkListAccessibilityOnLongPress => '長按並拖動到底部以刪除書籤';

  @override
  String get bookmarkListAccessibilitySelectOnTap => '點擊以選擇或取消選擇此書籤';

  @override
  String savedTimeFunction(Object part) {
    return '$part儲存';
  }

  @override
  String get savedTimeToday => '今天';

  @override
  String get savedTimeYesterday => '昨天';

  @override
  String savedTimeOthersFunction(Object days) {
    return '$days 天前';
  }

  @override
  String get deleteBookmarkSuccessfully => '刪除書籤成功';

  @override
  String get tocContinueReading => '繼續閱讀';

  @override
  String get tocStartReading => '開始閱讀';

  @override
  String get tocNoChapter => '沒有章節';

  @override
  String get readerLoadingInitialize => '正在初始化';

  @override
  String get readerLoadingBookLoading => '正在載入書籍';

  @override
  String get readerLoadingRendering => '正在渲染';

  @override
  String get readerSettingsResetButton => '重設設定';

  @override
  String get readerSettingsResetButtonDone => '重設成功';

  @override
  String get readerSettingsAutoSaveSwitch => '自動插入書籤';

  @override
  String get readerSettingsGesture => '翻頁手勢';

  @override
  String get readerSettingsFlippingAnime => '翻頁動畫';

  @override
  String get readerSettingsPageNumTypeLabel => '頁碼的顯示方式';

  @override
  String get readerSettingsPageNumTypeHelperText => '選擇頁碼的顯示方式';

  @override
  String get readerSettingsPageNumTypeHidden => '隱藏';

  @override
  String get readerSettingsPageNumTypeNumber => '頁數';

  @override
  String get readerSettingsPageNumTypePercentage => '百分比';

  @override
  String get readerSettingsPageNumTypeProgressBar => '進度條';

  @override
  String get readerSearch => '搜尋';

  @override
  String get readerSearchCurrentChapter => '章節';

  @override
  String get readerSearchAllRange => '全部';

  @override
  String get readerSearchTypeToSearch => '輸入以搜尋';

  @override
  String get readerSearchNoResult => '無結果';

  @override
  String readerSearchResultCount(Object number) {
    return '總共 $number 筆結果';
  }

  @override
  String get readerSearchCopyExcerpt => '複製摘要';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsPageAbout => '關於';

  @override
  String get settingsFeedback => '意見回饋';

  @override
  String get backupManagerTitle => '備份';

  @override
  String get backupManagerFileManagement => '備份檔案管理';

  @override
  String get backupManagerLabelAll => '全部';

  @override
  String get backupManagerLabelLibrary => '書櫃';

  @override
  String get backupManagerLabelCollection => '收藏';

  @override
  String get backupManagerLabelBookmark => '書籤';

  @override
  String get backupManagerBackupAll => '立即全部備份';

  @override
  String get backupManagerBackupLibrary => '備份所有書籍';

  @override
  String get backupManagerBackupCollection => '備份收藏';

  @override
  String get backupManagerBackupBookmark => '備份書籤';

  @override
  String get backupManagerBackupSuccessfully => '備份成功';

  @override
  String get backupManagerBackupFailed => '備份失敗';

  @override
  String get backupManagerRestoreAll => '全部復原';

  @override
  String get backupManagerRestoreLibrary => '復原所有書籍';

  @override
  String get backupManagerRestoreCollection => '復原收藏';

  @override
  String get backupManagerRestoreBookmark => '復原書籤';

  @override
  String get backupManagerRestoreSuccessfully => '復原成功';

  @override
  String get backupManagerRestoreFailed => '復原失敗';

  @override
  String get backupManagerDeleteAllBackup => '刪除所有備份';

  @override
  String get backupManagerDeleteLibraryBackup => '刪除所有書籍的備份';

  @override
  String get backupManagerDeleteCollectionBackup => '刪除收藏備份';

  @override
  String get backupManagerDeleteBookmarkBackup => '刪除書籤備份';

  @override
  String get backupManagerDeleteBackupSuccessfully => '成功刪除備份';

  @override
  String get backupManagerDeleteBackupFailed => '刪除備份失敗';

  @override
  String get backupManagerLastTime => '上次備份時間';

  @override
  String get backupManagerGoogleDrive => 'Google 雲端硬碟';

  @override
  String get resetPageTitle => '重設';

  @override
  String get resetPageDataTitle => '資料';

  @override
  String get resetPageDeleteAllBooks => '刪除所有書籍';

  @override
  String get resetPageDeleteAllBookmarks => '刪除所有書籤';

  @override
  String get resetPageDeleteAllCollections => '刪除所有收藏';

  @override
  String get resetPageCacheTitle => '快取';

  @override
  String get resetPageCacheClear => '清除所有快取';

  @override
  String get resetPagePreferenceTitle => '偏好設定';

  @override
  String get resetPageResetPreference => '重設所有偏好設定';

  @override
  String get resetPageResetThemeManager => '重設主題設定';

  @override
  String get resetPageResetBackupManager => '重設備份設定';

  @override
  String get resetPageResetBookshelf => '重設書櫃設定';

  @override
  String get resetPageResetCollectionList => '重設收藏列表設定';

  @override
  String get resetPageResetBookmarkList => '重設書籤列表設定';

  @override
  String get resetPageResetReader => '重設閱讀器設定';

  @override
  String get ttsSettingsTitle => '文字轉語音設定';

  @override
  String get ttsSettingsPlay => '播放';

  @override
  String get ttsSettingsPause => '暫停';

  @override
  String get ttsSettingsStop => '停止';

  @override
  String get ttsSettingsReset => '重設';

  @override
  String get ttsSettingsPitch => '音調';

  @override
  String get ttsSettingsVolume => '音量';

  @override
  String get ttsSettingsSpeechRate => '語速';

  @override
  String get ttsSettingsTypeHere => '在此輸入一些文字';

  @override
  String get languageCodeSqAL => '阿爾巴尼亞語（阿爾巴尼亞）';

  @override
  String get languageCodeAr => '阿拉伯';

  @override
  String get languageCodeAsIN => '阿薩姆語（印度）';

  @override
  String get languageCodeBnBD => '孟加拉語（孟加拉國）';

  @override
  String get languageCodeBnIN => '孟加拉語（印度）';

  @override
  String get languageCodeBrxIN => '博多（印度）';

  @override
  String get languageCodeBsBA => '波士尼亞語（波士尼亞與赫塞哥維納）';

  @override
  String get languageCodeBgBG => '保加利亞語（保加利亞語）';

  @override
  String get languageCodeYueHK => '粵語（香港）';

  @override
  String get languageCodeCaES => '加泰隆尼亞語（西班牙）';

  @override
  String get languageCodeZhCN => '中文（簡體，中國）';

  @override
  String get languageCodeZhTW => '中文（繁體，台灣）';

  @override
  String get languageCodeHrHR => '克羅埃西亞語（克羅埃西亞）';

  @override
  String get languageCodeCsCZ => '捷克語（捷克共和國）';

  @override
  String get languageCodeDaDK => '丹麥語（丹麥）';

  @override
  String get languageCodeDoiIN => '多格里（印度）';

  @override
  String get languageCodeNlBE => '荷蘭語（比利時）';

  @override
  String get languageCodeNlNL => '荷蘭語（荷蘭）';

  @override
  String get languageCodeEnAU => '英語（澳洲）';

  @override
  String get languageCodeEnIN => '英語（印度）';

  @override
  String get languageCodeEnNG => '英語（尼日利亞）';

  @override
  String get languageCodeEnGB => '英語（英國）';

  @override
  String get languageCodeEnUS => '英語（美國）';

  @override
  String get languageCodeEtEE => '愛沙尼亞語（愛沙尼亞）';

  @override
  String get languageCodeFilPH => '菲律賓語（菲律賓）';

  @override
  String get languageCodeFiFI => '芬蘭語（芬蘭）';

  @override
  String get languageCodeFrCA => '法語（加拿大）';

  @override
  String get languageCodeFrFR => '法語（法國）';

  @override
  String get languageCodeDeDE => '德語（德國）';

  @override
  String get languageCodeElGR => '希臘文（希臘文）';

  @override
  String get languageCodeGuIN => '古吉拉特語（印度）';

  @override
  String get languageCodeHeIL => '希伯來文（以色列）';

  @override
  String get languageCodeHiIN => '印地語（印度）';

  @override
  String get languageCodeHuHU => '匈牙利語（匈牙利）';

  @override
  String get languageCodeIsIS => '冰島語（冰島）';

  @override
  String get languageCodeIdID => '印尼語（印尼）';

  @override
  String get languageCodeItIT => '義大利語（義大利）';

  @override
  String get languageCodeJaJP => '日文（日本）';

  @override
  String get languageCodeJvID => '爪哇語（印尼）';

  @override
  String get languageCodeKnIN => '卡納達語（印度）';

  @override
  String get languageCodeKsIN => '克什米爾（印度）';

  @override
  String get languageCodeKmKH => '高棉語（柬埔寨）';

  @override
  String get languageCodeKokIN => '孔卡尼語（印度）';

  @override
  String get languageCodeKoKR => '韓語（韓國）';

  @override
  String get languageCodeLvLV => '拉脫維亞語（拉脫維亞）';

  @override
  String get languageCodeLtLT => '立陶宛語（立陶宛）';

  @override
  String get languageCodeMaiIN => '邁蒂利（印度）';

  @override
  String get languageCodeMsMY => '馬來語（馬來西亞）';

  @override
  String get languageCodeMlIN => '馬拉雅拉姆語（印度）';

  @override
  String get languageCodeMniIN => '曼尼普里語（印度梅泰）';

  @override
  String get languageCodeMrIN => '馬拉地語（印度）';

  @override
  String get languageCodeNeNP => '尼泊爾語（尼泊爾）';

  @override
  String get languageCodeNbNO => '挪威語博克馬爾語（挪威）';

  @override
  String get languageCodeOrIN => '奧迪亞（印度奧裡亞）';

  @override
  String get languageCodePlPL => '波蘭語（波蘭）';

  @override
  String get languageCodePtBR => '葡萄牙語（巴西）';

  @override
  String get languageCodePtPT => '葡萄牙語（葡萄牙）';

  @override
  String get languageCodePaIN => '旁遮普語（印度）';

  @override
  String get languageCodeRoRO => '羅馬尼亞語（羅馬尼亞）';

  @override
  String get languageCodeRuRU => '俄語（俄羅斯）';

  @override
  String get languageCodeSaIN => '梵文（印度）';

  @override
  String get languageCodeSatIN => '桑塔利（印度）';

  @override
  String get languageCodeSrRS => '塞爾維亞語（塞爾維亞）';

  @override
  String get languageCodeSdIN => '信德語（印度）';

  @override
  String get languageCodeSiLK => '僧伽羅語（斯里蘭卡）';

  @override
  String get languageCodeSkSK => '斯洛伐克（斯洛伐克）';

  @override
  String get languageCodeSlSI => '斯洛維尼亞語（斯洛維尼亞）';

  @override
  String get languageCodeEsES => '西班牙語（西班牙）';

  @override
  String get languageCodeEsUS => '西班牙語（美國）';

  @override
  String get languageCodeSuID => '巽他語（印尼）';

  @override
  String get languageCodeSwKE => '斯瓦希里語（肯亞）';

  @override
  String get languageCodeSvSE => '瑞典文（瑞典）';

  @override
  String get languageCodeTaIN => '泰米爾語（印度）';

  @override
  String get languageCodeTeIN => '泰盧固語（印度）';

  @override
  String get languageCodeThTH => '泰語（泰國）';

  @override
  String get languageCodeTrTR => '土耳其語（土耳其）';

  @override
  String get languageCodeUkUA => '烏克蘭語（烏克蘭）';

  @override
  String get languageCodeUrIN => '烏爾都語（印度）';

  @override
  String get languageCodeUrPK => '烏爾都語（巴基斯坦）';

  @override
  String get languageCodeViVN => '越南語（越南）';

  @override
  String get languageCodeCyGB => '威爾斯語（英國）';

  @override
  String languageCodeUnknown(Object code) {
    return '未知語言：\$$code';
  }

  @override
  String get privacyPolicy => '隱私權政策';

  @override
  String get fileEmpty => '未選擇檔案';

  @override
  String get fileTypeHelperText => '只接受以下檔案類型：';

  @override
  String get fileSystemUntitledFile => '無檔名';

  @override
  String fileSystemCreateOnDate(Object datetime) {
    return '建立於 $datetime';
  }

  @override
  String get fileSystemPermissionDenied => '拒絕存取';

  @override
  String get dialogDeleteTitle => '確定嗎？';

  @override
  String get dialogDeleteContent => '你將無法復原它們。';

  @override
  String get alertDialogResetSettingsTitle => '回復預設設定';

  @override
  String get alertDialogResetSettingsDescription => '確定回復預設設定嗎？';

  @override
  String get accessibilityBackButton => '返回';

  @override
  String get accessibilityAddBookButton => '新增書籍';

  @override
  String accessibilityThemeSelectionButton(Object name) {
    return '使用 $name 主題';
  }

  @override
  String get accessibilityAppIcon => 'NovelGlide 圖示';

  @override
  String get accessibilityBookCover => '書籍封面';

  @override
  String get accessibilityBookshelfListItem => '一本書';

  @override
  String get accessibilityBookshelfListItemOnTap => '點擊以開啟書籍';

  @override
  String get accessibilityBookshelfListItemOnLongPress => '長按並拖動到底部以刪除書籍';

  @override
  String get accessibilityReaderPrevChapterButton => '上一章';

  @override
  String get accessibilityReaderNextChapterButton => '下一章';

  @override
  String get accessibilityReaderBookmarkButton => '跳到書籤';

  @override
  String get accessibilityReaderAddBookmarkButton => '新增書籤';

  @override
  String get accessibilityReaderSettingsButton => '閱讀器設定';

  @override
  String get accessibilityFontSizeSliderMinIcon => '最小字型大小';

  @override
  String get accessibilityFontSizeSliderMaxIcon => '最大字型大小';

  @override
  String get accessibilityFontSizeSlider => '字型大小滑桿';

  @override
  String get accessibilityLineHeightSliderMinIcon => '最小行高';

  @override
  String get accessibilityLineHeightSliderMaxIcon => '最大行高';

  @override
  String get accessibilityLineHeightSlider => '行高滑桿';

  @override
  String get exceptionUnknownError => '發生未知的錯誤';
}

/// The translations for Chinese, as used in China, using the Han script (`zh_Hans_CN`).
class AppLocalizationsZhHansCn extends AppLocalizationsZh {
  AppLocalizationsZhHansCn(): super('zh_Hans_CN');

  @override
  String get generalEmpty => '空空如也';

  @override
  String get generalLoading => '载入中';

  @override
  String get generalSubmit => '送出';

  @override
  String get generalSelect => '选择';

  @override
  String get generalDelete => '删除';

  @override
  String get generalCancel => '取消';

  @override
  String get generalClose => '关闭';

  @override
  String get generalYes => '是';

  @override
  String get generalNo => '否';

  @override
  String get generalSave => '保存';

  @override
  String get generalDone => '完成';

  @override
  String get generalSelectAll => '全选';

  @override
  String get generalDeselectAll => '取消全选';

  @override
  String get generalDragHereToDelete => '拖到此处即可将其删除';

  @override
  String get generalAdd => '添加';

  @override
  String get generalName => '名称';

  @override
  String get generalReset => '重置';

  @override
  String get generalRefreshAndTryAgain => '请刷新并重试。';

  @override
  String get bookshelfTitle => '书架';

  @override
  String get bookshelfSortName => '书名';

  @override
  String get bookshelfSortLastModified => '添加时间';

  @override
  String get bookshelfNoBook => '没有书';

  @override
  String get bookshelfBookNotExist => '这本书不存在';

  @override
  String get bookshelfAccessibilityCheckbox => '点击以选择或取消选择这本书。';

  @override
  String get deleteBookSuccessfully => '成功删除该书';

  @override
  String get deleteBookFailed => '删除图书失败';

  @override
  String get addBookFailed => '添加图书失败';

  @override
  String get addBookDuplicated => '这本书已经存在了。';

  @override
  String get addToCollection => '添加到收藏夹';

  @override
  String get collectionTitle => '收藏';

  @override
  String get collectionNoCollection => '没有收藏';

  @override
  String get collectionAddBtn => '添加收藏';

  @override
  String get collectionAddTitle => '添加收藏';

  @override
  String get collectionName => '收藏名称';

  @override
  String get collectionAddSuccess => '该收藏已成功添加。';

  @override
  String collectionDelete(Object number) {
    return '删除 $number 个已选择的收藏';
  }

  @override
  String get collectionAddToCollections => '添加到收藏';

  @override
  String get collectionSaved => '收藏已保存。';

  @override
  String get collectionAddEmpty => '它不能为空。';

  @override
  String get bookmarkListTitle => '书签';

  @override
  String get bookmarkListNoBookmark => '没有保存的书签';

  @override
  String get bookmarkListSortName => '书签名称';

  @override
  String get bookmarkListSortSavedTime => '保存时间';

  @override
  String bookmarkListDeleteNumberOfSelectedBookmarks(Object number) {
    return '删除 $number 个已选择的书签';
  }

  @override
  String get bookmarkListAccessibilitySelectItem => '选择或取消选择书签';

  @override
  String get bookmarkListAccessibilityItem => '一个书签';

  @override
  String get bookmarkListAccessibilityOnTap => '点击以从书签位置继续阅读';

  @override
  String get bookmarkListAccessibilityOnLongPress => '长按并拖动到底部以删除书签';

  @override
  String get bookmarkListAccessibilitySelectOnTap => '点击以选择或取消选择此书签';

  @override
  String savedTimeFunction(Object part) {
    return '$part保存';
  }

  @override
  String get savedTimeToday => '今天';

  @override
  String get savedTimeYesterday => '昨天';

  @override
  String savedTimeOthersFunction(Object days) {
    return '$days 天前';
  }

  @override
  String get deleteBookmarkSuccessfully => '删除书签成功';

  @override
  String get tocContinueReading => '继续阅读';

  @override
  String get tocStartReading => '开始阅读';

  @override
  String get tocNoChapter => '没有章节';

  @override
  String get readerLoadingInitialize => '正在初始化';

  @override
  String get readerLoadingBookLoading => '加载书籍中';

  @override
  String get readerLoadingRendering => '正在渲染';

  @override
  String get readerSettingsResetButton => '重置设置';

  @override
  String get readerSettingsResetButtonDone => '重置成功';

  @override
  String get readerSettingsAutoSaveSwitch => '自动插入书签';

  @override
  String get readerSettingsGesture => '翻页手势';

  @override
  String get readerSettingsFlippingAnime => '翻页动画';

  @override
  String get readerSettingsPageNumTypeLabel => '页码显示方法';

  @override
  String get readerSettingsPageNumTypeHelperText => '选择页码的显示方式';

  @override
  String get readerSettingsPageNumTypeHidden => '隐藏';

  @override
  String get readerSettingsPageNumTypeNumber => '页数';

  @override
  String get readerSettingsPageNumTypePercentage => '百分比';

  @override
  String get readerSettingsPageNumTypeProgressBar => '进度条';

  @override
  String get readerSearch => '搜索';

  @override
  String get readerSearchCurrentChapter => '章节';

  @override
  String get readerSearchAllRange => '全部';

  @override
  String get readerSearchTypeToSearch => '输入以搜索';

  @override
  String get readerSearchNoResult => '没有结果';

  @override
  String readerSearchResultCount(Object number) {
    return '总共 $number 个结果';
  }

  @override
  String get readerSearchCopyExcerpt => '复制摘录';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsPageAbout => '关于';

  @override
  String get settingsFeedback => '反馈';

  @override
  String get backupManagerTitle => '备份';

  @override
  String get backupManagerFileManagement => '备份文件管理';

  @override
  String get backupManagerLabelAll => '全部';

  @override
  String get backupManagerLabelLibrary => '书架';

  @override
  String get backupManagerLabelCollection => '收藏';

  @override
  String get backupManagerLabelBookmark => '书签';

  @override
  String get backupManagerBackupAll => '立即全部备份';

  @override
  String get backupManagerBackupLibrary => '备份所有书籍';

  @override
  String get backupManagerBackupCollection => '备份收藏';

  @override
  String get backupManagerBackupBookmark => '备份书签';

  @override
  String get backupManagerBackupSuccessfully => '备份成功';

  @override
  String get backupManagerBackupFailed => '备份失败';

  @override
  String get backupManagerRestoreAll => '全部恢复';

  @override
  String get backupManagerRestoreLibrary => '恢复所有书籍';

  @override
  String get backupManagerRestoreCollection => '恢复收藏';

  @override
  String get backupManagerRestoreBookmark => '恢复书签';

  @override
  String get backupManagerRestoreSuccessfully => '恢复成功';

  @override
  String get backupManagerRestoreFailed => '恢复失败';

  @override
  String get backupManagerDeleteAllBackup => '删除所有备份';

  @override
  String get backupManagerDeleteLibraryBackup => '删除所有书籍的备份';

  @override
  String get backupManagerDeleteCollectionBackup => '删除收藏备份';

  @override
  String get backupManagerDeleteBookmarkBackup => '删除书签备份';

  @override
  String get backupManagerDeleteBackupSuccessfully => '成功删除备份';

  @override
  String get backupManagerDeleteBackupFailed => '删除备份失败';

  @override
  String get backupManagerLastTime => '上次备份时间';

  @override
  String get backupManagerGoogleDrive => 'Google 云端硬盘';

  @override
  String get resetPageTitle => '重置';

  @override
  String get resetPageDataTitle => '数据';

  @override
  String get resetPageDeleteAllBooks => '删除所有书籍';

  @override
  String get resetPageDeleteAllBookmarks => '删除所有书签';

  @override
  String get resetPageDeleteAllCollections => '删除所有收藏';

  @override
  String get resetPageCacheTitle => '缓存';

  @override
  String get resetPageCacheClear => '清除所有缓存';

  @override
  String get resetPagePreferenceTitle => '偏好设置';

  @override
  String get resetPageResetPreference => '重置所有偏好设置';

  @override
  String get resetPageResetThemeManager => '重置主题设置';

  @override
  String get resetPageResetBackupManager => '重置备份设置';

  @override
  String get resetPageResetBookshelf => '重置书架设置';

  @override
  String get resetPageResetCollectionList => '重置收藏列表设置';

  @override
  String get resetPageResetBookmarkList => '重置书签列表设置';

  @override
  String get resetPageResetReader => '重置阅读器设置';

  @override
  String get ttsSettingsTitle => '文本转语音设置';

  @override
  String get ttsSettingsPlay => '播放';

  @override
  String get ttsSettingsPause => '暂停';

  @override
  String get ttsSettingsStop => '停止';

  @override
  String get ttsSettingsReset => '重置';

  @override
  String get ttsSettingsPitch => '音调';

  @override
  String get ttsSettingsVolume => '音量';

  @override
  String get ttsSettingsSpeechRate => '语速';

  @override
  String get ttsSettingsTypeHere => '在此输入一些文字';

  @override
  String get languageCodeSqAL => '阿尔巴尼亚语（阿尔巴尼亚）';

  @override
  String get languageCodeAr => '阿拉伯';

  @override
  String get languageCodeAsIN => '阿萨姆语（印度）';

  @override
  String get languageCodeBnBD => '孟加拉语（孟加拉国）';

  @override
  String get languageCodeBnIN => '孟加拉语（印度）';

  @override
  String get languageCodeBrxIN => '博多（印度）';

  @override
  String get languageCodeBsBA => '波斯尼亚语（波斯尼亚和黑塞哥维那）';

  @override
  String get languageCodeBgBG => '保加利亚语（保加利亚）';

  @override
  String get languageCodeYueHK => '粤语（香港）';

  @override
  String get languageCodeCaES => '加泰罗尼亚语（西班牙）';

  @override
  String get languageCodeZhCN => '中文（简体，中国）';

  @override
  String get languageCodeZhTW => '中文（繁体，台湾）';

  @override
  String get languageCodeHrHR => '克罗地亚语（克罗地亚）';

  @override
  String get languageCodeCsCZ => '捷克语（捷克共和国）';

  @override
  String get languageCodeDaDK => '丹麦语（丹麦）';

  @override
  String get languageCodeDoiIN => '多格里（印度）';

  @override
  String get languageCodeNlBE => '荷兰语（比利时）';

  @override
  String get languageCodeNlNL => '荷兰语（荷兰）';

  @override
  String get languageCodeEnAU => '英语（澳大利亚）';

  @override
  String get languageCodeEnIN => '英语（印度）';

  @override
  String get languageCodeEnNG => '英语（尼日利亚）';

  @override
  String get languageCodeEnGB => '英语（英国）';

  @override
  String get languageCodeEnUS => '英语（美国）';

  @override
  String get languageCodeEtEE => '爱沙尼亚语（爱沙尼亚）';

  @override
  String get languageCodeFilPH => '菲律宾语（菲律宾）';

  @override
  String get languageCodeFiFI => '芬兰语（芬兰）';

  @override
  String get languageCodeFrCA => '法语（加拿大）';

  @override
  String get languageCodeFrFR => '法语（法国）';

  @override
  String get languageCodeDeDE => '德语（德国）';

  @override
  String get languageCodeElGR => '希腊语（希腊）';

  @override
  String get languageCodeGuIN => '古吉拉特语（印度）';

  @override
  String get languageCodeHeIL => '希伯来语（以色列）';

  @override
  String get languageCodeHiIN => '印地语（印度）';

  @override
  String get languageCodeHuHU => '匈牙利语（匈牙利）';

  @override
  String get languageCodeIsIS => '冰岛语（冰岛）';

  @override
  String get languageCodeIdID => '印度尼西亚语（印度尼西亚）';

  @override
  String get languageCodeItIT => '意大利语（意大利）';

  @override
  String get languageCodeJaJP => '日语（日本）';

  @override
  String get languageCodeJvID => '爪哇语（印度尼西亚）';

  @override
  String get languageCodeKnIN => '卡纳达语（印度）';

  @override
  String get languageCodeKsIN => '克什米尔（印度）';

  @override
  String get languageCodeKmKH => '高棉语（柬埔寨）';

  @override
  String get languageCodeKokIN => '孔卡尼语（印度）';

  @override
  String get languageCodeKoKR => '韩语（韩国）';

  @override
  String get languageCodeLvLV => '拉脱维亚语（拉脱维亚）';

  @override
  String get languageCodeLtLT => '立陶宛语（立陶宛）';

  @override
  String get languageCodeMaiIN => '迈蒂利（印度）';

  @override
  String get languageCodeMsMY => '马来语（马来西亚）';

  @override
  String get languageCodeMlIN => '马拉雅拉姆语（印度）';

  @override
  String get languageCodeMniIN => '曼尼普里语（印度梅泰）';

  @override
  String get languageCodeMrIN => '马拉地语（印度）';

  @override
  String get languageCodeNeNP => '尼泊尔语（尼泊尔）';

  @override
  String get languageCodeNbNO => '挪威语博克马尔语（挪威）';

  @override
  String get languageCodeOrIN => '奥迪亚（印度奥里亚）';

  @override
  String get languageCodePlPL => '波兰语（波兰）';

  @override
  String get languageCodePtBR => '葡萄牙语（巴西）';

  @override
  String get languageCodePtPT => '葡萄牙语（葡萄牙）';

  @override
  String get languageCodePaIN => '旁遮普语（印度）';

  @override
  String get languageCodeRoRO => '罗马尼亚语（罗马尼亚）';

  @override
  String get languageCodeRuRU => '俄语（俄罗斯）';

  @override
  String get languageCodeSaIN => '梵文（印度）';

  @override
  String get languageCodeSatIN => '桑塔利（印度）';

  @override
  String get languageCodeSrRS => '塞尔维亚语（塞尔维亚）';

  @override
  String get languageCodeSdIN => '信德语（印度）';

  @override
  String get languageCodeSiLK => '僧伽罗语（斯里兰卡）';

  @override
  String get languageCodeSkSK => '斯洛伐克（斯洛伐克）';

  @override
  String get languageCodeSlSI => '斯洛文尼亚语（斯洛文尼亚）';

  @override
  String get languageCodeEsES => '西班牙语（西班牙）';

  @override
  String get languageCodeEsUS => '西班牙语（美国）';

  @override
  String get languageCodeSuID => '巽他语（印度尼西亚）';

  @override
  String get languageCodeSwKE => '斯瓦希里语（肯尼亚）';

  @override
  String get languageCodeSvSE => '瑞典语（瑞典）';

  @override
  String get languageCodeTaIN => '泰米尔语（印度）';

  @override
  String get languageCodeTeIN => '泰卢固语（印度）';

  @override
  String get languageCodeThTH => '泰语（泰国）';

  @override
  String get languageCodeTrTR => '土耳其语（土耳其）';

  @override
  String get languageCodeUkUA => '乌克兰语（乌克兰）';

  @override
  String get languageCodeUrIN => '乌尔都语（印度）';

  @override
  String get languageCodeUrPK => '乌尔都语（巴基斯坦）';

  @override
  String get languageCodeViVN => '越南语（越南）';

  @override
  String get languageCodeCyGB => '威尔士语（英国）';

  @override
  String languageCodeUnknown(Object code) {
    return '未知语言：\$$code';
  }

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get fileEmpty => '未选择文件';

  @override
  String get fileTypeHelperText => '仅接受以下类型的文件：';

  @override
  String get fileSystemUntitledFile => '无标题文件';

  @override
  String fileSystemCreateOnDate(Object datetime) {
    return '创建于 $datetime';
  }

  @override
  String get fileSystemPermissionDenied => '没有权限';

  @override
  String get dialogDeleteTitle => '你确定吗？';

  @override
  String get dialogDeleteContent => '您将无法恢复它们。';

  @override
  String get alertDialogResetSettingsTitle => '回复默认设置';

  @override
  String get alertDialogResetSettingsDescription => '确定回复默认设置吗？';

  @override
  String get accessibilityBackButton => '返回';

  @override
  String get accessibilityAddBookButton => '新增书籍';

  @override
  String accessibilityThemeSelectionButton(Object name) {
    return '使用 $name 主题';
  }

  @override
  String get accessibilityAppIcon => 'NovelGlide 图标';

  @override
  String get accessibilityBookCover => '书籍封面';

  @override
  String get accessibilityBookshelfListItem => '一本书';

  @override
  String get accessibilityBookshelfListItemOnTap => '点击以打开书籍';

  @override
  String get accessibilityBookshelfListItemOnLongPress => '长按并拖动到底部以删除书籍';

  @override
  String get accessibilityReaderPrevChapterButton => '上一章';

  @override
  String get accessibilityReaderNextChapterButton => '下一章';

  @override
  String get accessibilityReaderBookmarkButton => '跳到书签';

  @override
  String get accessibilityReaderAddBookmarkButton => '新增书签';

  @override
  String get accessibilityReaderSettingsButton => '阅读器设置';

  @override
  String get accessibilityFontSizeSliderMinIcon => '最小字体大小';

  @override
  String get accessibilityFontSizeSliderMaxIcon => '最大字体大小';

  @override
  String get accessibilityFontSizeSlider => '字体大小滑块';

  @override
  String get accessibilityLineHeightSliderMinIcon => '最小行高';

  @override
  String get accessibilityLineHeightSliderMaxIcon => '最大行高';

  @override
  String get accessibilityLineHeightSlider => '行高滑块';

  @override
  String get exceptionUnknownError => '发生未知错误';
}
