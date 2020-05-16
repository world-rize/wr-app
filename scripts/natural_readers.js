// naturalreadlers から音声をダウンロードする
// F12 Console に貼り付ける
(async () => {
  const sleep = async (s) => new Promise(resolve => setTimeout(resolve, s * 1000))
  for (let row of document.getElementsByClassName('cell-name')) {
    row.click()
    await sleep(5)
    // download
    document.getElementsByClassName('mat-raised-button')[2].click()
    await sleep(1)
    // download all as separate mp3
    document.getElementsByClassName('mat-menu-item ng-star-inserted')[1].click()
    history.back()
    await sleep(10)
  }
})();

// タイトル取得
[...document.getElementsByClassName('name-test')].map(el => el.innerHTML.replace(/^\s+|\s+$/g, '')).join(',')