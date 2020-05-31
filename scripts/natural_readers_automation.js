// naturalreadlers から音声をダウンロードする
// F12 Console に貼り付ける
(async () => {
  // ex: 301-400 => page 4
  let [begin, end] = [750, 1000]
  const sleep = async (s) => new Promise(resolve => setTimeout(resolve, s * 1000))
  const page = (i) => Math.floor((i - 1) / 100) + 1
  const next = async () => {
    document.getElementsByClassName('mat-paginator-navigation-next')[0].click()
    await sleep(1)
  }
  const to = async (p) => {
    for (let i = 0; i < p - 1; i++) {
      await next()
    }
  }
  const scrape = async (i) => {
    // to page
    await to(page(i))

    const row = document.getElementsByClassName('cell-name')[(i - 1) % 100]

    row.click()
    await sleep(6)
    // download
    document.getElementsByClassName('mat-raised-button')[2].click()
    await sleep(1)
    // download all as separate mp3
    document.getElementsByClassName('mat-menu-item ng-star-inserted')[1].click()
    history.back()
    await sleep(10)
  }

  for (let i = begin; i <= end; i++) {
    await scrape(i)
  }
})();

// タイトル取得
[...document.getElementsByClassName('name-test')].map(el => el.innerHTML.replace(/^\s+|\s+$/g, '')).join(',')