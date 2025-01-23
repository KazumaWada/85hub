module ApplicationHelper
    def default_meta_tags
        {
          site: '詐欺師の手帳',
          title: '詐欺師の手帳',
          reverse: true,
          charset: 'utf-8',
          description: '詐欺被害の未然防止を目的としたアプリです',
          canonical: request.original_url,
          og: {
            site_name: '詐欺師の手帳',
            title: '詐欺師の手帳',
            description: '詐欺被害の未然防止を目的としたアプリです',
            type: 'website',
            url: request.original_url,
            image: image_url('write.png'),
            local: 'ja-JP'
          },
          twitter: {
            card: 'summary_large_image',
            site: '@https://x.com/yukimura877',
            image: image_url('write.png')
          }
        }
      end
end
