document.addEventListener('turbo:load', function () {
  let image_upload = document.querySelector('#micropost_image');
  if (image_upload) {
    image_upload.addEventListener('change', function (event) {
      const size_in_megabytes = image_upload.files[0].size / 1024 / 1024;
      if (size_in_megabytes > Settings.models.micropost.img_size) {
        alert(I18n.t('models.microposts.size_error'));
        image_upload.value = '';
      }
    });
  }
});
