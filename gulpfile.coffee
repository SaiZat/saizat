# 初期値
assets_path = "assets"
input_path = "src"
output_path = "dist"
admin_input_path = "src/admin"
admin_output_path =  "dist/admin"
type_list = ["fonts", "pdf", "mail", "xml", "video", "yml", "json"]

gulp = require "gulp"
notify = require "gulp-notify" #エラー通知
plumber = require "gulp-plumber" #エラー強制停止の防止
changed = require "gulp-changed" #変更したファイルだけ実行
usemin = require "gulp-usemin" #HTMLで圧縮
cssmin = require "gulp-cssmin" #css圧縮
uglify = require "gulp-uglify" #js圧縮
save_license = require "uglify-save-license" #license表記
imagemin = require "gulp-imagemin" #image圧縮
pngquant	= require "imagemin-pngquant" #png圧縮
sass = require "gulp-sass" #scssコンパイル
autoprefixer = require "gulp-autoprefixer" #prefixer付与
csscomb = require "gulp-csscomb" #cssプロパティの順序調整
mmq = require "gulp-merge-media-queries" #メディアクエリ調整
concat = require "gulp-concat" #ファイル結合
rename = require "gulp-rename"; #リネーム
coffee = require "gulp-coffee"; #coffeeコンパイル
babel = require('gulp-babel'); #babel

browsersync = require "browser-sync" #ブラウザリロード
connect = require "gulp-connect-php" #PHP

###
mozjpeg	= require "imagemin-mozjpeg"
jpegoptim	= require "imagemin-jpegoptim"
del = require "del"
csslint = require "gulp-csslint"
###



#Indexのコンパイル
compileIndexFile = (done) ->
	baseCompileIndexFile input_path, output_path
	done()
compileIndexFileAdmin = (done) ->
	baseCompileIndexFile admin_input_path, admin_output_path
	done()

baseCompileIndexFile = (p_input_path, p_output_path)->
	gulp.src [p_input_path+"/index.+(html|php)"]
		.pipe plumber
			errorHandler: notify.onError "Error: <%= error %>"
		.pipe changed p_output_path
		.pipe usemin
			css: [cssmin()]
			js: [uglify({output: {comments: save_license}})]
		.pipe gulp.dest p_output_path
		.pipe browsersync.stream()


#テンプレートファイルの移動
moveTempleteFileDirect = (done) ->
	baseMoveTempleteFile input_path, output_path
	done()
moveTempleteFileAdmin = (done) ->
	baseMoveTempleteFile admin_input_path, admin_output_path
	done()
moveTempleteFileJa = (done) ->
	baseMoveTempleteFileOther input_path, output_path, "ja"
	done()
moveTempleteFileEn = (done) ->
	baseMoveTempleteFileOther input_path, output_path, "en"
	done()
moveTempleteFileZh = (done) ->
	baseMoveTempleteFileOther input_path, output_path, "zh"
	done()

baseMoveTempleteFile = (p_input_path, p_output_path)->
	gulp.src [p_input_path+"/**/*.+(html|php)", "!"+p_input_path+"/index.+(html|php)", "!"+p_input_path+"/admin/index.+(html|php)", "!"+p_input_path+"/**/php/**/*.+(html|php)", "!"+p_input_path+"/ja/**/*.+(html|php)", "!"+p_input_path+"/en/**/*.+(html|php)", "!"+p_input_path+"/zh/**/*.+(html|php)"]
		.pipe plumber
			errorHandler: notify.onError "Error: <%= error %>"
		.pipe changed p_output_path
		.pipe gulp.dest p_output_path
		.pipe browsersync.stream()
baseMoveTempleteFileOther = (p_input_path, p_output_path, p_lang)->
	gulp.src [p_input_path+"/"+p_lang+"/**/*.+(html|php)"]
		.pipe plumber
			errorHandler: notify.onError "Error: <%= error %>"
		.pipe changed p_output_path+"/"+p_lang
		.pipe gulp.dest p_output_path+"/"+p_lang
		.pipe browsersync.stream()


#PHPファイルの移動
movePHPFile = (done) ->
	baseMovePHPFile input_path, output_path
	done()
movePHPFileAdmin = (done) ->
	baseMovePHPFile admin_input_path, admin_output_path
	done()

baseMovePHPFile = (p_input_path, p_output_path)->
	gulp.src [p_input_path+"/php/**/*.+(html|php)"]
		.pipe plumber
			errorHandler: notify.onError "Error: <%= error %>"
		.pipe changed p_output_path+"/php"
		.pipe gulp.dest p_output_path+"/php"
		.pipe browsersync.stream()


# サブファイルの移動タスク
moveSubFile = (done) ->
	baseMoveSubFile input_path, output_path, type_list
	done()
moveSubFileAdmin = (done) ->
	baseMoveSubFile admin_input_path, admin_output_path, type_list
	done()

baseMoveSubFile = (p_input_path, p_output_path, p_type)->
	for type in p_type
		gulp.src [p_input_path+"/"+assets_path+"/"+type+"/**/*"]
			.pipe plumber
				errorHandler: notify.onError "Error: <%= error %>"
			.pipe changed p_output_path+"/"+assets_path+"/"+type
			.pipe gulp.dest p_output_path+"/"+assets_path+"/"+type
			.pipe browsersync.stream()


# 画像の圧縮
compileImage = (done) ->
	baseCompileImage input_path, output_path
	done()
compileImageAdmin = (done) ->
	baseCompileImage admin_input_path, admin_output_path
	done()

baseCompileImage = (p_input_path, p_output_path)->
	gulp.src [p_input_path+"/"+assets_path+"/img/**/*.+(png|jpg|jpeg|gif|svg|ico)", "!"+p_input_path+"/"+assets_path+"/img/**/*_nc.+(png|jpg|jpeg|gif|svg|ico)"]
		.pipe plumber
			errorHandler: notify.onError "Error: <%= error %>"
		.pipe changed p_output_path+"/"+assets_path+"/img"
		.pipe imagemin(
			[
				pngquant
					quality: [0.6, 0.8]
					speed: 1
			]
		)
		.pipe gulp.dest p_output_path+"/"+assets_path+"/img"
		.pipe browsersync.stream()


#画像の圧縮なし
moveImage = (done) ->
	baseMoveImage input_path, output_path
	done()
moveImageAdmin = (done) ->
	baseMoveImage admin_input_path, admin_output_path
	done()

baseMoveImage = (p_input_path, p_output_path)->
	gulp.src [p_input_path+"/"+assets_path+"/img/**/*_nc.+(png|jpg|jpeg|gif|svg|ico)"]
		.pipe plumber
			errorHandler: notify.onError "Error: <%= error %>"
		.pipe changed p_output_path+"/"+assets_path+"/img"
		.pipe gulp.dest p_output_path+"/"+assets_path+"/img"
		.pipe browsersync.stream()


#scssのコンパイル
complileScss = (done) ->
	baseComplileScss input_path, output_path
	done()
complileScssAdmin = (done) ->
	#baseComplileScss admin_input_path, admin_output_path
	done()

baseComplileScss = (p_input_path, p_output_path)->
	gulp.src [p_input_path+"/"+assets_path+"/css/common.scss", p_input_path+"/"+assets_path+"/css/pc.scss", p_input_path+"/"+assets_path+"/css/sp.scss"]
		.pipe plumber
			errorHandler: notify.onError "Error: <%= error %>"
		#scssコンパイル
		.pipe sass()
		#cssベンダープレフィックス付与
		.pipe autoprefixer
			cascade: false
		#cssプロパティ順の調整
		.pipe csscomb()
		#cssメディアクエリ順の調整
		.pipe mmq
			log: true
		#出力
		.pipe gulp.dest p_output_path+"/"+assets_path+"/tmp/css"
		#css結合
		.pipe concat "common.css"
		#cssメディアクエリ順の調整
		.pipe mmq
			log: true
		#css圧縮
		.pipe cssmin()
		# 名前変更
		.pipe rename
			suffix: ".min"
		#出力
		.pipe gulp.dest p_output_path+"/"+assets_path+"/css"
		.pipe browsersync.stream()

	gulp.src [p_input_path+"/"+assets_path+"/css/**/*.scss", "!"+p_input_path+"/"+assets_path+"/css/common.scss", "!"+p_input_path+"/"+assets_path+"/css/pc.scss", "!"+p_input_path+"/"+assets_path+"/css/sp.scss"]
		.pipe plumber
			errorHandler: notify.onError "Error: <%= error %>"
		#scssコンパイル
		.pipe sass()
		#cssベンダープレフィックス付与
		.pipe autoprefixer
			cascade: false
		#cssプロパティ順の調整
		.pipe csscomb()
		#cssメディアクエリ順の調整
		.pipe mmq
			log: true
		#出力
		.pipe gulp.dest p_output_path+"/"+assets_path+"/tmp/css"
		#cssメディアクエリ順の調整
		#css圧縮
		.pipe cssmin()
		# 名前変更
		.pipe rename
			suffix: ".min"
		#出力
		.pipe gulp.dest p_output_path+"/"+assets_path+"/css"
		.pipe browsersync.stream()


#coffeeのコンパイル
complileCoffee = (done) ->
	baseCompileCoffee input_path, output_path
	done()
complileCoffeeAdmin = (done) ->
	baseCompileCoffee admin_input_path, admin_output_path

baseCompileCoffee = (p_input_path, p_output_path)->
	gulp.src [p_input_path+"/"+assets_path+"/js/**/*.coffee"]
		.pipe plumber
			errorHandler: notify.onError "Error: <%= error %>"
		#js結合
		#.pipe concat "main.js"
		# coffeeコンパイル
		.pipe coffee()
		.pipe gulp.dest p_output_path+"/"+assets_path+"/tmp/js"
		#js圧縮
		.pipe(babel({
			"presets": ["@babel/preset-env"]
		}))
		.pipe uglify()
		.pipe rename
			suffix: ".min"
		.pipe gulp.dest p_output_path+"/"+assets_path+"/js"
		.pipe browsersync.stream()


#jsの移動
moveJS = (done) ->
	baseMoveJS input_path, output_path
	done()
moveJSAdmin = (done) ->
	baseMoveJS admin_input_path, admin_output_path
	done()

baseMoveJS = (p_input_path, p_output_path)->
	gulp.src p_input_path+"/"+assets_path+"/js/**/*.js"
		.pipe plumber
			errorHandler: notify.onError "Error: <%= error %>"
		.pipe changed p_output_path+"/"+assets_path+"/js"
		.pipe gulp.dest p_output_path+"/"+assets_path+"/js/"
		.pipe browsersync.stream()


#webサーバー開始
connectSync= (done) ->
	connect.server {
		port: 8008
		base: output_path
		ini: "C:/xampp/php/php.ini"
		bin: "C:/xampp/php/php.exe"
	}, ->
		browsersync proxy: 'localhost:8008'
		return
	return


#webサーバー停止
disconnect= (done) ->
	connect.closeServer()
	done()


# ブラウザ同期
browserSync= (done) ->
	browsersync
		server:
			baseDir: output_path
	done()


# ブラウザリロード
browserSyncReload= (done) ->
	browsersync.reload()
	done()


# 監視
watch= (done) ->
	console.log "watch"
	#index
	gulp.watch [input_path+"/index.+(html|php)"], gulp.series compileIndexFile
	gulp.watch [admin_input_path+"/index.+(html|php)"], gulp.series compileIndexFileAdmin

	#template
	gulp.watch [input_path+"/**/*.+(html|php)", "!"+input_path+"/index.+(html|php)", "!"+input_path+"/admin/index.+(html|php)", "!"+input_path+"/**/php/**/*.+(html|php)",  "!"+input_path+"/ja/**/*.+(html|php)", "!"+input_path+"/en/**/*.+(html|php)", "!"+input_path+"/zh/**/*.+(html|php)"], gulp.series moveTempleteFileDirect, moveTempleteFileAdmin
	gulp.watch [input_path+"/ja/**/*.+(html|php)"], gulp.series moveTempleteFileJa
	gulp.watch [input_path+"/en/**/*.+(html|php)"], gulp.series moveTempleteFileEn
	gulp.watch [input_path+"/zh/**/*.+(html|php)"], gulp.series moveTempleteFileZh

	#file
	gulp.watch [input_path+"/php/**/*.+(html|php)"], gulp.series movePHPFile
	gulp.watch [admin_input_path+"/php/**/*.+(html|php)"], gulp.series movePHPFileAdmin

	#assets
	for type in type_list
		gulp.watch [input_path+"/"+assets_path+"/"+type+"/**/*"], gulp.series moveSubFile
		gulp.watch [admin_input_path+"/"+assets_path+"/"+type+"/**/*"], gulp.series moveSubFileAdmin

	#image
	gulp.watch [input_path+"/"+assets_path+"/img/**/*.+(png|jpg|jpeg|gif|svg|ico)", "!"+input_path+"/"+assets_path+"/img/**/*_nc.+(png|jpg|jpeg|gif|svg|ico)"], gulp.series compileImage, moveImage
	gulp.watch [admin_input_path+"/"+assets_path+"/img/**/*.+(png|jpg|jpeg|gif|svg|ico)", "!"+admin_input_path+"/"+assets_path+"/img/**/*_nc.+(png|jpg|jpeg|gif|svg|ico)"], gulp.series compileImageAdmin, moveImageAdmin

	#scss
	gulp.watch [input_path+"/"+assets_path+"/css/**/*.scss"], gulp.series complileScss
	gulp.watch [admin_input_path+"/"+assets_path+"/css/**/*.scss"], gulp.series complileScssAdmin

	#coffee, js
	gulp.watch [input_path+"/"+assets_path+"/js/**/*.coffee"], gulp.series complileCoffee
	gulp.watch [admin_input_path+"/"+assets_path+"/js/**/*.coffee"], gulp.series complileCoffeeAdmin
	gulp.watch [input_path+"/"+assets_path+"/js/**/*.js"], gulp.series moveJS
	gulp.watch [admin_input_path+"/"+assets_path+"/js/**/*.js"], gulp.series moveJSAdmin




# 設定
exports.default = gulp.parallel connectSync, watch
exports.all = gulp.series compileIndexFile, compileIndexFileAdmin, moveTempleteFileDirect, moveTempleteFileAdmin, moveTempleteFileJa, moveTempleteFileEn, moveTempleteFileZh, movePHPFile, movePHPFileAdmin, moveSubFile, moveSubFileAdmin, compileImage, compileImageAdmin, moveImage, moveImageAdmin, complileScss, complileScssAdmin, complileCoffee, complileCoffeeAdmin, moveJS, moveJSAdmin
exports.img = gulp.series compileImage, compileImageAdmin, moveImage, moveImageAdmin
exports.css = gulp.series complileScss, complileScssAdmin
exports.js = gulp.series complileCoffee, complileCoffeeAdmin, moveJS, moveJSAdmin
exports.file = gulp.series compileIndexFile, compileIndexFileAdmin, moveTempleteFileDirect, moveTempleteFileAdmin, moveTempleteFileJa, moveTempleteFileEn, moveTempleteFileZh, movePHPFile, movePHPFileAdmin, moveSubFile, moveSubFileAdmin, movePHPFile, movePHPFileAdmin
exports.discon = gulp.series disconnect

exports.test1 = gulp.series compileIndexFile, compileIndexFileAdmin
exports.test2 = gulp.series moveTempleteFileDirect, moveTempleteFileAdmin, moveTempleteFileJa, moveTempleteFileEn, moveTempleteFileZh
exports.test3 = gulp.series movePHPFile, movePHPFileAdmin
exports.test4 = gulp.series moveSubFile, moveSubFileAdmin
exports.test5 = gulp.series compileImage, compileImageAdmin
exports.test6 = gulp.series moveImage, moveImageAdmin
exports.test7 = gulp.series complileScss, complileScssAdmin
exports.test8 = gulp.series complileCoffee, complileCoffeeAdmin
exports.test9 = gulp.series moveJS, moveJSAdmin
