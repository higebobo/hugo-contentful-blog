// contentful-hugo.config.js
module.exports = {
    repeatableTypes: [
        {
            id: 'hugoContentfulPost',             // (1) model id for blog post
            directory: 'content/post',            // (2) output directory for hugo
            mainContent: 'body',                  // (3) filed id for content
            resolveEntries: [
                {
                    field: 'categories',          // (4) field id for taxonomy, category
                    resolveTo: 'fields.title',    // (5) reference filed for the above
                },
                {
                    field: 'tags',                // (6) field id for taxonomy, tag
                    resolveTo: 'fields.title',    // (7) reference filed for the above
                },
            ],
            overrides: [
                {
                    field: 'eyecatch',                    // (8) field id for image
                    options: {
                        fieldName: 'image',               // (9) replace field name
                        valueTransformer: (value) => {
                            return value.fields.file.url; // (10) value for the above
                        },
                    },
                },
            ],
        },
        {
            id: 'hugoContentfulCategory',         // (11) model id for blog category
            directory: 'content/categories',      // (12) output directory for hugo
            isTaxonomy: true,
        },
        {
            id: 'hugoContentfulTag',              // (13) model id for blog category
            directory: 'content/tags',            // (14) output directory for hugo
            isTaxonomy: true,
        }
    ],
    staticContent: [
        {
            inputDir: 'static',
            outputDir: 'content',
        },
    ],
};
