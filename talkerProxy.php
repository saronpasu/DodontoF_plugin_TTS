<?php

date_default_timezone_set('Asia/Tokyo');
mb_internal_encoding("UTF-8");
mb_regex_encoding('UTF-8');

$queryText = (isset($_POST['queryText']) && $_POST['queryText']) ? $_POST['queryText'] : 'undefined';

$url_replaced = $queryText;

if($url_replaced == 'undefined'){ print ''; exit; }

$url_replaced_decoded = urldecode($url_replaced);

// 固有名詞置換
// Elysion関連
$url_replaced_decoded = preg_replace('/elysion/i',' えりゅしおん ',$url_replaced_decoded);

$url_replaced_decoded = preg_replace('/「/ui','・',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/」/ui','・',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/^：(\d+) \((\d+D%*\d+).*/',' だいすろーる・$2・合計・$1 ',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/^：+/ui','',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/([^a-zA-Zａ-ｚＡ-Ｚ])[wｗ]+$/ui','$1・わら ',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/([^a-zA-Zａ-ｚＡ-Ｚ])[wｗ]{2,}/ui','$1・',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/[\.。．・…]{2,}/ui','・',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/…/ui','・',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/(ftp|http|https)\:\/\/.*/ui','・$1のurlです・',$url_replaced_decoded);

// 辞書系
$url_replaced_decoded = preg_replace('/↑/ui','・うえ・',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/↓/ui','・した・',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/←/ui','・ひだり・',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/→/ui','・みぎ・',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/欠片/ui','かけら',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/SANチェック/ui','さんちぇっく',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/ＳＡＮチェック/ui','さんちぇっく',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/百合展開/ui','きましたわー',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/百合/ui','ゆり',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/ktkr/ui','きたこれ',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/ｋｔｋｒ/ui','きたこれ',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/ksk/ui','かそく',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/ｋｓｋ/ui','かそく',$url_replaced_decoded);
$url_replaced_decoded = preg_replace('/晶石/ui','しょうせき',$url_replaced_decoded);


#/* Open JTalk を使う場合

// 音声ファイルとかを格納するディレクトリ
$voice_dir = "sound/tts/";

// ユニークなIDを生成、それを元にファイル名を命名。
$uid = uniqid();
$input_file = $voice_dir . $uid . ".txt";
$output_file = $voice_dir . $uid . ".wav";

// 読み上げ用にクエリ内容を一時的にテキストファイルへ出力
$fp = fopen($input_file, 'w+');
fwrite($fp, $url_replaced_decoded);
fclose($fp);

// リファラから相対パスを取得して、tts.rb(TTS専用のCGI)の相対パスを取得する。
$referer = $_SERVER["HTTP_REFERER"];
$url = preg_replace('/DodontoF\.swf/', 'tts.rb', $referer);

$data = array(
    'input_file' => $input_file,
    'output_file' => $output_file,
);
$headers = array(
    'User-Agent: Mozilla/5.5\r\n'
);
$options = array(
    'http' => array(
    'method' => 'GET',
    'content' => http_build_query($data),
    'header' => implode("\r\n", $headers),
));

/* Google TTS を使う場合
// 通常取得
$url_replaced_reencoded = urlencode($url_replaced_decoded);
$url = 'http://translate.google.com/translate_tts?tl=ja&q='.$url_replaced_reencoded;

$option = array(
   	'http'=>array(
       	'method'=>"GET",
       	'header' => "User-Agent:Mozilla/5.5\r\n". //Mozillaを指定
                   	"Content-type: application/x-www-form-urlencoded\r\n".
                   	"Accept-Language: ja-jp,en;q=0.5\r\n".
                   	"Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7" ));
*/

//print "$url\n";
//GoogleTTS Open JTalk共通処理。
$context = stream_context_create($option);


$fp = @fopen($url, 'r', false, $context);
if($fp){
	fpassthru($fp);
	fclose($fp);
}
#*/

?>
