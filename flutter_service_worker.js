'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "c4e92dfb72cf19f95c7a8ae00211d334",
"version.json": "2b85c8e1a13f937080e6187fe6f38d85",
"index.html": "6a0bc442012e69e024a4507cff4040dc",
"/": "6a0bc442012e69e024a4507cff4040dc",
"main.dart.js": "33af25c684430991fffecd3e6e33e54d",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "0b2bae856f9bc3ce24503e199022c905",
"assets/AssetManifest.json": "43a1ec4808fab16c74c812549405b20b",
"assets/NOTICES": "fa183eb3ea91760cb781acc12affb170",
"assets/FontManifest.json": "72354ba4f5cc7099b1cf2482b55dd2c5",
"assets/AssetManifest.bin.json": "9851d8a44fc5a9c29170d0b59593c40c",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/core/assets/harry_potter.ttf": "0421d4186d6efbfc5331fe180895e780",
"assets/packages/core/assets/hogwards_express.png": "30e505076a5479fe15aee8cb8b3d60f0",
"assets/packages/core/assets/eyesglasses.png": "0ac06ca977d7ecadbf76fc24ed190c94",
"assets/packages/core/assets/lightning.png": "0b51f20e8fc46ed00361bd2cb9e48537",
"assets/packages/core/assets/harry_potter/background_music.mp3": "be38ce5d5ca980ef075057113e14327e",
"assets/packages/core/assets/harry_potter/hat.png": "331bb80523f9cef2859791db5cafb04e",
"assets/packages/core/assets/harry_potter/question/u/harry_potter_video.mp4": "555eefefa80b16213818024b30f35412",
"assets/packages/core/assets/harry_potter/question/u/info.json": "e203e7797e5c2c4a8f8e57b5f96e9231",
"assets/packages/core/assets/harry_potter/question/a/harry_potter_video.mp4": "ad817a3a75aaca8c5b454ca90dfbf769",
"assets/packages/core/assets/harry_potter/question/a/info.json": "4d5a317d45fe6cd6262d4084f1691697",
"assets/packages/core/assets/harry_potter/question/o/harry_potter_video.mp4": "c496629631c6f81cb52806e8733244bc",
"assets/packages/core/assets/harry_potter/question/o/info.json": "6b6012a51eea07e9d13f8f10aefc4a8d",
"assets/packages/core/assets/harry_potter/question/q/harry_potter_video.mp4": "21bd72c958525040222469b1ef29dd2c",
"assets/packages/core/assets/harry_potter/question/q/info.json": "d56b3aaaca04732f2e0bcfd558cf2155",
"assets/packages/core/assets/cross.png": "09f9119ed2d90ed3b1956721bc5e3702",
"assets/packages/core/assets/exam.png": "0d4224b1286259292cb63f5377afe086",
"assets/packages/core/assets/hogwards_background.png": "483898b74f2cf39c84d1e4e00b885ab7",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "803dc3634514477f01c810e7b3668cb6",
"assets/fonts/MaterialIcons-Regular.otf": "e0be04970ed1c94f4f2264aa3be8e56f",
"assets/assets/harry_potter.ttf": "0421d4186d6efbfc5331fe180895e780",
"assets/assets/hogwards_express.png": "30e505076a5479fe15aee8cb8b3d60f0",
"assets/assets/eyesglasses.png": "0ac06ca977d7ecadbf76fc24ed190c94",
"assets/assets/lightning.png": "0b51f20e8fc46ed00361bd2cb9e48537",
"assets/assets/harry_potter/background_music.mp3": "be38ce5d5ca980ef075057113e14327e",
"assets/assets/harry_potter/hat.png": "331bb80523f9cef2859791db5cafb04e",
"assets/assets/harry_potter/question/u/harry_potter_video.mp4": "555eefefa80b16213818024b30f35412",
"assets/assets/harry_potter/question/u/info.json": "e203e7797e5c2c4a8f8e57b5f96e9231",
"assets/assets/harry_potter/question/a/harry_potter_video.mp4": "ad817a3a75aaca8c5b454ca90dfbf769",
"assets/assets/harry_potter/question/a/info.json": "4d5a317d45fe6cd6262d4084f1691697",
"assets/assets/harry_potter/question/o/harry_potter_video.mp4": "c496629631c6f81cb52806e8733244bc",
"assets/assets/harry_potter/question/o/info.json": "6b6012a51eea07e9d13f8f10aefc4a8d",
"assets/assets/harry_potter/question/q/harry_potter_video.mp4": "21bd72c958525040222469b1ef29dd2c",
"assets/assets/harry_potter/question/q/info.json": "d56b3aaaca04732f2e0bcfd558cf2155",
"assets/assets/cross.png": "09f9119ed2d90ed3b1956721bc5e3702",
"assets/assets/exam.png": "0d4224b1286259292cb63f5377afe086",
"assets/assets/hogwards_background.png": "483898b74f2cf39c84d1e4e00b885ab7",
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
