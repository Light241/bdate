var gulp = require('gulp');
var concat = require('gulp-concat');
var rename = require('gulp-rename');
var uglify = require('gulp-uglify');
var jade = require('gulp-jade');
var sourcemaps = require('gulp-sourcemaps');
var watch = require('gulp-watch');
var changed = require('gulp-changed');
var ngAnnotate = require('gulp-ng-annotate');
var stylus = require('gulp-stylus');
var nib = require('nib');
var minifyHTML = require('gulp-minify-html');
var minifyCss = require('gulp-minify-css');
var coffee = require('gulp-coffee');

var src = {
    styles: {
        src: [
            'src/styles/**/*.styl'
        ]
    },
    jade: {
        src: [
            'src/*.jade',
            'src/**/*.jade'
        ]
    },
    js: ['src/**/*.js'],
    coffee: ['src/**/*.coffee']
};

var dest = {
    dist: 'dist',
    src: 'src'
};


gulp.task('coffee', function () {
    gulp.src(src.coffee)
        .pipe(coffee({bare: true}))
        .on('error', console.log)
        .pipe(concat('bdate.js'))
        .pipe(ngAnnotate({remove: true, add: true, single_quotes: true}))
        .pipe(gulp.dest(dest.dist))
        .pipe(sourcemaps.init())
        .pipe(uglify())
        .pipe(rename({basename: 'bdate.min'}))
        .pipe(sourcemaps.write('.'))
        .pipe(gulp.dest(dest.dist))
});

gulp.task('jade', function () {
    return gulp.src(src.jade.src)
        .pipe(changed(dest.dist, {extension: '.html'}))
        .pipe(jade({pretty: false}))
        .on('error', console.log)
        .pipe(minifyHTML({
            empty: true,
            spare: true
        }))
        .pipe(gulp.dest(dest.dist));
});

gulp.task('stylus', function () {
    return gulp.src(src.styles.src, {base: 'src'})
        .pipe(concat('bdate.styl'))
        .pipe(stylus({use: [nib()], compress: true}))
        .on('error', console.log)
        .pipe(minifyCss())
        .pipe(gulp.dest(dest.dist));
});

gulp.task('watch', function () {
    gulp.watch(src.jade.src, ['jade']);
    gulp.watch(src.styles.src, ['stylus']);
    gulp.watch(src.coffee, ['coffee']);
});

gulp.task('build', function () {
    gulp.start('coffee');
    gulp.start('jade');
    gulp.start('stylus');
});

gulp.task('default', function () {
    gulp.start('build');
    gulp.start('watch');
});