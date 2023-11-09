# Mason

## brickを作成

```sh
mason new [feature name]
```

## brickからコードを取得

プロジェクトに`mason.yaml`を設置する

```yaml
bricks:
  feature:
    git:
      url: https://github.com/never-inc/mason.git
      path: bricks/feature
  project_template:
    git:
      url: https://github.com/never-inc/mason.git
      path: bricks/project_template
```

bricksに設定されている情報を取り込む

```sh
mason get
```

brickを指定してコードを生成する

```sh
mason make [feature name] # mason make project_template
```