'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "fbd6c47c13865067fdf454e5e6037efc",
"version.json": "2b85c8e1a13f937080e6187fe6f38d85",
"index.html": "f15d0034f4185c577dbbde152c9061ed",
"/": "f15d0034f4185c577dbbde152c9061ed",
"main.dart.js": "c64a511271e5cd954acaf6ed0bf173cf",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "0b2bae856f9bc3ce24503e199022c905",
"assets/AssetManifest.json": "53385a1d119c3f0295be65b3010603fe",
"assets/NOTICES": "ea28d0da3acce5a1148f9e2b4ca20780",
"assets/FontManifest.json": "37e916ff976c249e6b50c38e89ccfc74",
"assets/AssetManifest.bin.json": "26bc5ac01134ed9c6901925f29a4666d",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/core/assets/harry_potter.ttf": "0421d4186d6efbfc5331fe180895e780",
"assets/packages/core/assets/hogwards_express.png": "30e505076a5479fe15aee8cb8b3d60f0",
"assets/packages/core/assets/eyesglasses.png": "0ac06ca977d7ecadbf76fc24ed190c94",
"assets/packages/core/assets/lightning.png": "0b51f20e8fc46ed00361bd2cb9e48537",
"assets/packages/core/assets/harry_potter/background_music.mp3": "be38ce5d5ca980ef075057113e14327e",
"assets/packages/core/assets/harry_potter/hat.png": "331bb80523f9cef2859791db5cafb04e",
"assets/packages/core/assets/harry_potter/question/r/percy.webp": "2064088cfa2c3ef4262f84b519ac3862",
"assets/packages/core/assets/harry_potter/question/r/institute.png": "65d0190a5296e13be0af4e35763b8033",
"assets/packages/core/assets/harry_potter/question/r/institute.webp": "09c1b8e2c2f12c0dca6cd35c8275d25c",
"assets/packages/core/assets/harry_potter/question/r/info.json": "6dc807487b2aba28f3a56dba717b67aa",
"assets/packages/core/assets/harry_potter/question/r/igor.webp": "42d17333ac937a7b78d309516b5b93a1",
"assets/packages/core/assets/harry_potter/question/r/victor.png": "db1bf56f3edf13749ed040b63059e508",
"assets/packages/core/assets/harry_potter/question/r/grindelwald.jpg": "98777394af6ae008f6d0c2fbda7b005f",
"assets/packages/core/assets/harry_potter/question/r/percy.png": "4a030489416e0ae5782661b2db11c8ca",
"assets/packages/core/assets/harry_potter/question/r/igor.png": "73b43de9fe8251c8e6f46fc6adc72c7c",
"assets/packages/core/assets/harry_potter/question/u/harry_potter_video.mp4": "555eefefa80b16213818024b30f35412",
"assets/packages/core/assets/harry_potter/question/u/info.json": "d3cbe57fc0255ebb3c1731856ff550b1",
"assets/packages/core/assets/harry_potter/question/i/george.png": "eb0fac3d0a3a41b3d17cd04169a0f83f",
"assets/packages/core/assets/harry_potter/question/i/george.webp": "fa7fb294e15c84e560ce71702de616d5",
"assets/packages/core/assets/harry_potter/question/i/alicia.png": "67d7253abd0af65fb9638290b4c0d2bd",
"assets/packages/core/assets/harry_potter/question/i/vincent.webp": "04ada7789e0e19848b33133b4a0ea398",
"assets/packages/core/assets/harry_potter/question/i/vincent.png": "9c87e60663de35006e4d10664a34fb92",
"assets/packages/core/assets/harry_potter/question/i/draco.jpg": "3431e12f4f765ee94981a2263a0b951c",
"assets/packages/core/assets/harry_potter/question/i/alicia.webp": "c50aef617dc8ee82b2df16c017ea6e11",
"assets/packages/core/assets/harry_potter/question/i/harry_wand.png": "f4753146dbf9f55ada7a262a256cbde5",
"assets/packages/core/assets/harry_potter/question/i/info.json": "8dfdb2976f999e9f10d514bef87b280d",
"assets/packages/core/assets/harry_potter/question/i/amanda.webp": "c434cf34371b89b28f71e393593b64e6",
"assets/packages/core/assets/harry_potter/question/i/amanda.png": "43bd1ff20c185a35cde2f44879053aae",
"assets/packages/core/assets/harry_potter/question/n/harry_map.webp": "6c46548dbde1a285ddc063b0174ace79",
"assets/packages/core/assets/harry_potter/question/n/harry_map.png": "1c98cfdaed7f96ed568424a2bd7f9ec2",
"assets/packages/core/assets/harry_potter/question/n/info.json": "90127337268e43c406f2fe129316d05a",
"assets/packages/core/assets/harry_potter/question/g/snape.png": "e9b756086da700ed32864807cc32cee6",
"assets/packages/core/assets/harry_potter/question/g/snape.webp": "048f760ee470397e7808d3edb0ad0a66",
"assets/packages/core/assets/harry_potter/question/g/cat.png": "79b2a438142ca9cf4a80f2c9e660bfb9",
"assets/packages/core/assets/harry_potter/question/g/cat.webp": "ed9ec4ccf5242ead900ab361e2918b75",
"assets/packages/core/assets/harry_potter/question/g/sprout.webp": "bee0f3bff646480e68ea58679d57112b",
"assets/packages/core/assets/harry_potter/question/g/sprout.png": "409fdf18c1f41f15bb9ef62d72981683",
"assets/packages/core/assets/harry_potter/question/g/info.json": "df4f61348d779566bf1416e1311f25be",
"assets/packages/core/assets/harry_potter/question/g/mcgonagall.jpg": "fb05ab28e14b425b9ca95ade1818b2e2",
"assets/packages/core/assets/harry_potter/question/g/flitwick.jpeg": "7f7716f2396e76128cd44d4503d4bc3e",
"assets/packages/core/assets/harry_potter/question/t/monmarcus.png": "43c8eee2b45e9e1fc06d9a93efcd731f",
"assets/packages/core/assets/harry_potter/question/t/romilda.webp": "5f67e6ab63d2e776c9d9f1452ac2f4e0",
"assets/packages/core/assets/harry_potter/question/t/header2.png": "6a4b080e5e477226465a3402e79463bc",
"assets/packages/core/assets/harry_potter/question/t/hector.webp": "98f2456d5bcd29a76eccdbcce99c967c",
"assets/packages/core/assets/harry_potter/question/t/angelina.png": "1aa9f2ef42723e7fb252e792b2ee118d",
"assets/packages/core/assets/harry_potter/question/t/monmarcus.webp": "1fa92af260b785c7b0d03134613b56ed",
"assets/packages/core/assets/harry_potter/question/t/terry.webp": "b56aa4bee8f79316e9ab8831427e9263",
"assets/packages/core/assets/harry_potter/question/t/sirius.png": "387c2ef6fd1e7e34c0b89e302c094a7d",
"assets/packages/core/assets/harry_potter/question/t/hector.png": "44998e01d407618146ead230a4464bca",
"assets/packages/core/assets/harry_potter/question/t/angelina.webp": "14891b9c5ae13266bc1e045e7ba4174c",
"assets/packages/core/assets/harry_potter/question/t/header.png": "97560e9f09ae556c5af47308baf3f3f5",
"assets/packages/core/assets/harry_potter/question/t/romilda.png": "2a68e4177e0b1e5066aaf9a3fed77a96",
"assets/packages/core/assets/harry_potter/question/t/terry.png": "9098af6d9480ada1b3e2c1ee770cb4b0",
"assets/packages/core/assets/harry_potter/question/t/lawrence.png": "ebefb3b5de5a9c9f7442277d8bfe4329",
"assets/packages/core/assets/harry_potter/question/t/info.json": "af1efd15ac4655bf7184fff363414633",
"assets/packages/core/assets/harry_potter/question/t/lawrence.webp": "707c24a5c9ab0e07e964c6e0a66fde62",
"assets/packages/core/assets/harry_potter/question/t/sirius.webp": "4c3c8712fdbde7c5b230af5db8021a0c",
"assets/packages/core/assets/harry_potter/question/s/dragon.png": "868477be257734d10e8e5b8ca59f5252",
"assets/packages/core/assets/harry_potter/question/s/info.json": "70be5f9283e4b6346893d129d1c09604",
"assets/packages/core/assets/harry_potter/question/s/lobalug.png": "d8275e952ff9ff7b97648797ae013f64",
"assets/packages/core/assets/harry_potter/question/s/dragon.webp": "d1b76982ee84ffde5e59303a844232f1",
"assets/packages/core/assets/harry_potter/question/a/harry_potter_video.mp4": "ad817a3a75aaca8c5b454ca90dfbf769",
"assets/packages/core/assets/harry_potter/question/a/info.json": "ec619ec084b1c9fbc7d801fccc926fc3",
"assets/packages/core/assets/harry_potter/question/f/ron.png": "b1a69577d18b4c20451ee9c4a2d97d12",
"assets/packages/core/assets/harry_potter/question/f/harry_wand.png": "851369d6d89c9e18c1e346e0419a9b25",
"assets/packages/core/assets/harry_potter/question/f/info.json": "d14d6ba190f2e226faa1d195e13f56b0",
"assets/packages/core/assets/harry_potter/question/o/harry_potter_video.mp4": "c496629631c6f81cb52806e8733244bc",
"assets/packages/core/assets/harry_potter/question/o/info.json": "209efe13111f63b082a13dca76b6c530",
"assets/packages/core/assets/harry_potter/question/h/nicolas.jpg": "dbf512920697f13d82ace469588f3e3c",
"assets/packages/core/assets/harry_potter/question/h/info.json": "f27ea556225bd1719ee0562543e73889",
"assets/packages/core/assets/harry_potter/question/m/nigel.png": "e7a86f99c3220c7b8ac289482b1f5591",
"assets/packages/core/assets/harry_potter/question/m/susan.webp": "6c9f9f79756a2e9e8abad48c931040fe",
"assets/packages/core/assets/harry_potter/question/m/susan.png": "1ce7a1565fd4e015d629f44453eb47c5",
"assets/packages/core/assets/harry_potter/question/m/nigel.webp": "34a3a53648ff25c7b35a001bbcf5f650",
"assets/packages/core/assets/harry_potter/question/m/lucius.png": "8802aadd9d0a7b5d4a8ac810edba8b35",
"assets/packages/core/assets/harry_potter/question/m/header.png": "ab9839db51176fd278b53cb525584a95",
"assets/packages/core/assets/harry_potter/question/m/info.json": "0b1a03a0ed88d476d04232b67738bb75",
"assets/packages/core/assets/harry_potter/question/m/theseus.png": "e050b206a29571d7a6ff518c00620996",
"assets/packages/core/assets/harry_potter/question/m/theseus.webp": "0faa9ae4388194b38324e90a19521392",
"assets/packages/core/assets/harry_potter/question/m/lucius.webp": "b48b71383f3497c30e48dd79afcd779d",
"assets/packages/core/assets/harry_potter/question/j/ron.webp": "cf2bb31ac52277c3c235d2e745556225",
"assets/packages/core/assets/harry_potter/question/j/victor.webp": "3ccd1041137879e0d38ec974f37cbabe",
"assets/packages/core/assets/harry_potter/question/j/ron.png": "851d5648904a321109a86edc85fc1612",
"assets/packages/core/assets/harry_potter/question/j/yule_ball.jpeg": "b75b75db82c8c129a5c932c7282bdca4",
"assets/packages/core/assets/harry_potter/question/j/info.json": "bb1b1031015223e88267263add5b4c39",
"assets/packages/core/assets/harry_potter/question/j/victor.png": "db1bf56f3edf13749ed040b63059e508",
"assets/packages/core/assets/harry_potter/question/j/cedric.jpeg": "a5460ae90d51f23925f4c92358e19878",
"assets/packages/core/assets/harry_potter/question/j/harry.jpeg": "5344fa39e056373bfed4537831375d5a",
"assets/packages/core/assets/harry_potter/question/j/yule_ball2.jpeg": "0ee14f6ff4af5d8b2812c089624c199c",
"assets/packages/core/assets/harry_potter/question/c/voldemort.jpeg": "05a53ba15e1aacdf335cd9d654d21d8e",
"assets/packages/core/assets/harry_potter/question/c/bellatrix.jpeg": "e37ae0cb5f4098cb508648e2d883f403",
"assets/packages/core/assets/harry_potter/question/c/sirius_black.jpg": "bc927917f14e7c42f85ee8a2bc0adc92",
"assets/packages/core/assets/harry_potter/question/c/fenrir.jpg": "22adc79e6f56448a180ef3618d22bd0d",
"assets/packages/core/assets/harry_potter/question/c/lucius.jpg": "7e6a73ca627032c81a225f50ccbeaaed",
"assets/packages/core/assets/harry_potter/question/c/info.json": "c273e31aa8dbda7cd81348160f24daaa",
"assets/packages/core/assets/harry_potter/question/d/quidditch.png": "1f829831c7b883a5271833017b4e8b6c",
"assets/packages/core/assets/harry_potter/question/d/info.json": "d35efbe0bd3a45539b449a3f2f093b2d",
"assets/packages/core/assets/harry_potter/question/v/header2.png": "cb10f2b8907e1d9c9a1ab3c315d15c68",
"assets/packages/core/assets/harry_potter/question/v/trolley.webp": "95a536cc008ea7d74f742358ebb3ee4e",
"assets/packages/core/assets/harry_potter/question/v/angelina.png": "1aa9f2ef42723e7fb252e792b2ee118d",
"assets/packages/core/assets/harry_potter/question/v/trolley.png": "5812912c214c6fae713f7e279ad3cfee",
"assets/packages/core/assets/harry_potter/question/v/ominis.png": "c2711990ff55dca65949db1ce1ee4798",
"assets/packages/core/assets/harry_potter/question/v/angelina.webp": "14891b9c5ae13266bc1e045e7ba4174c",
"assets/packages/core/assets/harry_potter/question/v/ominis.webp": "cf904f3ae415e2eeeed074e52c36001a",
"assets/packages/core/assets/harry_potter/question/v/header.png": "38190686786f3e01f2650c1ef055865d",
"assets/packages/core/assets/harry_potter/question/v/info.json": "62140125760f3c71fa4f28f8a6e48c4e",
"assets/packages/core/assets/harry_potter/question/v/harry.jpeg": "5dfe60d25d00c23fdb04521babf9da9e",
"assets/packages/core/assets/harry_potter/question/q/harry_potter_video.mp4": "21bd72c958525040222469b1ef29dd2c",
"assets/packages/core/assets/harry_potter/question/q/info.json": "12a6da248c12822b74297e1b83b193b3",
"assets/packages/core/assets/harry_potter/question/e/nymphadora.jpg": "5ff419acd53e96ad8eca226ae06b6840",
"assets/packages/core/assets/harry_potter/question/e/info.json": "896fbe8c3b0b016de9e01cece6bbc80d",
"assets/packages/core/assets/harry_potter/question/b/ron.png": "d66cc4718244a385034ef51da1540c48",
"assets/packages/core/assets/harry_potter/question/b/info.json": "35fca41d83e6d289e45f48f9555533ca",
"assets/packages/core/assets/harry_potter/question/b/ron.jpeg": "355f08bacb0ad91ac3d96068fbbfd4cd",
"assets/packages/core/assets/harry_potter/question/k/monmarcus.png": "43c8eee2b45e9e1fc06d9a93efcd731f",
"assets/packages/core/assets/harry_potter/question/k/trolley.webp": "95a536cc008ea7d74f742358ebb3ee4e",
"assets/packages/core/assets/harry_potter/question/k/angelina.png": "1aa9f2ef42723e7fb252e792b2ee118d",
"assets/packages/core/assets/harry_potter/question/k/monmarcus.webp": "1fa92af260b785c7b0d03134613b56ed",
"assets/packages/core/assets/harry_potter/question/k/terry.webp": "b56aa4bee8f79316e9ab8831427e9263",
"assets/packages/core/assets/harry_potter/question/k/trolley.png": "5812912c214c6fae713f7e279ad3cfee",
"assets/packages/core/assets/harry_potter/question/k/ominis.png": "c2711990ff55dca65949db1ce1ee4798",
"assets/packages/core/assets/harry_potter/question/k/angelina.webp": "14891b9c5ae13266bc1e045e7ba4174c",
"assets/packages/core/assets/harry_potter/question/k/ominis.webp": "cf904f3ae415e2eeeed074e52c36001a",
"assets/packages/core/assets/harry_potter/question/k/header.png": "38190686786f3e01f2650c1ef055865d",
"assets/packages/core/assets/harry_potter/question/k/terry.png": "9098af6d9480ada1b3e2c1ee770cb4b0",
"assets/packages/core/assets/harry_potter/question/k/fred.webp": "02f6fda283f0726287a6a821c06b4663",
"assets/packages/core/assets/harry_potter/question/k/info.json": "12f9664186229fbe5c55f56df7e0dce6",
"assets/packages/core/assets/harry_potter/question/k/fred.png": "d5436c0b018339e59b9c206d99dbad30",
"assets/packages/core/assets/harry_potter/question/l/info.json": "1ccae83acf424439288d787cf896fb82",
"assets/packages/core/assets/harry_potter/question/l/lobalug.png": "d8275e952ff9ff7b97648797ae013f64",
"assets/packages/core/assets/harry_potter/question/p/snape.jpg": "30da3cebcceaac5e85a4f2c82be68b9d",
"assets/packages/core/assets/harry_potter/question/p/heade_moody.webp": "0527ddfe9a3e9e77bc79e1a042ae7d6e",
"assets/packages/core/assets/harry_potter/question/p/barty.webp": "55d20f4f429c39669b9c505c9edb546e",
"assets/packages/core/assets/harry_potter/question/p/heade_moody.png": "da361349806c172b1530e157e8826407",
"assets/packages/core/assets/harry_potter/question/p/lucius.jpg": "826505750ec1fbdc46770d31e1896673",
"assets/packages/core/assets/harry_potter/question/p/peter.jpeg": "cf8a3518f8f4783a7fd4989b42bb095f",
"assets/packages/core/assets/harry_potter/question/p/info.json": "ed354eb56ce50dcb0cf792b583fa8d13",
"assets/packages/core/assets/harry_potter/question/p/barty.png": "f29df7752d9357fcc7e7058853358c5b",
"assets/packages/core/assets/harry_potter/house/hufflepuff.webp": "5df0bf76294d5eb04a6ef02502da031b",
"assets/packages/core/assets/harry_potter/house/slytherin.webp": "ebf4b779d2e7eed84fc48ad41c444deb",
"assets/packages/core/assets/harry_potter/house/ravenclaw.webp": "7246a344eb857a5472253427b72a65f5",
"assets/packages/core/assets/harry_potter/house/slytherin.png": "15fc60ba16354bd5c5ce4e273dc1130a",
"assets/packages/core/assets/harry_potter/house/gryffindor.webp": "df1d3a5b23362e75bfe77a25cb12dec3",
"assets/packages/core/assets/harry_potter/house/ravenclaw.png": "fea1efcc70d36568bbc09f4fddeed98f",
"assets/packages/core/assets/harry_potter/house/gryffindor.png": "0625d002c0ec2305bfafe4d9486e3ce6",
"assets/packages/core/assets/harry_potter/house/hufflepuff.png": "a6b98f022e767cfbcd85147c5f682041",
"assets/packages/core/assets/cross.png": "09f9119ed2d90ed3b1956721bc5e3702",
"assets/packages/core/assets/exam.png": "0d4224b1286259292cb63f5377afe086",
"assets/packages/core/assets/hogwards_background.png": "483898b74f2cf39c84d1e4e00b885ab7",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "ec3dc99b334c821b555a6a5c4f02ff10",
"assets/fonts/MaterialIcons-Regular.otf": "e0be04970ed1c94f4f2264aa3be8e56f",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
