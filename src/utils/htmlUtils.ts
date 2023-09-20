/**
 * Exec browser download.
 * @param fileName
 * @param content
 * @param mime
 */
const download = (fileName: string, content: BlobPart, mime: string | undefined): void => {
  const downLoadLink: HTMLAnchorElement = document.createElement("a")
  downLoadLink.download = fileName
  downLoadLink.href = URL.createObjectURL(new Blob([content], { type: mime }))
  downLoadLink.dataset.downloadurl = [mime, downLoadLink.download, downLoadLink.href].join(":")
  downLoadLink.click()
}

export { download }
