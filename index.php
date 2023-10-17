<?php
require_once('php/init.php');
?>

<!DOCTYPE html>
<html lang="ja">

<head>
	<meta charset="utf-8">
	<meta http-equiv="x-ua-compatible" content="IE=edge">
	<title></title>
	<meta name="description" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<meta name="copyright" content="">
	<meta name="author" content="">
	<meta name="Targeted Geographic Area" content="Japan">
	<meta name="coverage" content="Japan">
	<meta name="rating" content="general">
	<meta name="content-language" content="ja">
	<meta name="format-detection" content="telephone=no">
	<link rel="canonical" href="">

	<meta property="og:site_name" content="">
	<meta property="og:title" content="">
	<meta property="og:locale" content="ja_JP">
	<meta property="og:type" content="website">
	<meta property="og:url" content="">
	<meta property="og:image" content="">
	<meta property="og:description" content="">

	<meta name="twitter:card" content="summary_large_image">
	<meta name="twitter:site" content="@">
	<meta name="twitter:image" content="">

	<!-- build:css assets/css/vender.min.css -->
	<link rel="stylesheet" href="assets/css/vendor/modaal.css">
	<link rel="stylesheet" href="assets/css/vendor/slick.css">
	<!-- endbuild -->

	<link rel="stylesheet" href="assets/css/common.min.css">
</head>

<body>

	<!-- wrapper -->
	<div id="wrapper">

		<!-- innerWrapper -->
		<div id="innerWrapper">

			<!-- header -->
			<!-- <?php require_once("php/layouts/contents_header.php"); ?> -->
			<!-- /header -->

			<!-- ctArea -->
			<div id="ctArea" class="topPage">
				<div class="heading">
					<figure class="logo">
						<img src="assets/img/logo.webp" alt="logo" >
					</figure>
					<a href="entrance/index.php" class="entranceLink">WELCOME TO THE AAPP MUSEUM</a>
					<p class="warning">Warning: Contains distressing images</p>
				</div>
				<a href="entrance/index.php" class="enter"></a>
			</div>
			<!-- /ctArea -->

			<!-- footer -->
			<?php require_once("php/layouts/contents_footer.php"); ?>
			<!-- /footer -->

		</div>
		<!-- / innerWrap -->

	</div>
	<!-- / wrapper -->


	<!--build:js assets/js/vendor.min.js -->
	<script type="text/javascript" src="assets/js/vendor/jquery-3.7.0.min.js"></script>
	<script type="text/javascript" src="assets/js/vendor/jquery.easing.js"></script>
	<script type="text/javascript" src="assets/js/vendor/modaal.js"></script>
	<script type="text/javascript" src="assets/js/vendor/slick.min.js"></script>
	<!-- endbuild -->

	<script type="text/javascript" src="assets/js/common.min.js"></script>
	<script type="text/javascript" src="assets/js/other.js"></script>
</body>

</html>
