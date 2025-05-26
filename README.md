# d2l-tool

本仓库包含一系列工具，旨在辅助《动手学习深度学习》(Dive into Deep Learning) 一书的 Jupyter Notebook 构建和本地开发过程。

## 脚本和文档说明

### 1. `fix_missing_tabs.sh` - 修复缺失的 MXNet 框架标签

*   **用途**：此脚本用于为 Markdown 文件中所有 MXNet 框架的代码块自动添加 `#@tab mxnet` 标签。
*   **问题背景**：`d2lbook` 默认将不带框架标签的代码块识别为 MXNet。然而，在某些环境（如 macOS）中，MXNet 可能未安装或与 MLX 等其他框架存在冲突。在执行 `d2lbook build eval --tab mlx` 时，这些未显式标记的 MXNet 代码块仍会被尝试构建，从而导致因缺少 MXNet 库而产生的错误。通过为 MXNet 代码块添加 `#@tab mxnet`，可以确保 `d2lbook` 正确识别它们，并在构建时进行相应处理。
    *   **原始代码块示例**：
        ```python
        ```{.python .input}
        # some MXNet code...
        print("Hello from MXNet")
        ```
        ```
    *   **处理后代码块示例**：
        ```{.python .input}
        #@tab mxnet
        # some MXNet code...
        print("Hello from MXNet")
        ```
*   **使用方法**：
    1.  进入需要处理的 Markdown 文件所在的目录（例如 `cd chapter_computer-vision`）。
    2.  在该目录下执行脚本：`bash fix_missing_tabs.sh`。
    3.  按照脚本的命令行提示进行操作。

### 2. `cleanup_tags.sh` - 清理错误的 MXNet 框架标签

*   **用途**：此脚本用于全面清理 Markdown 文件中错误位置的 `#@tab mxnet` 标记。例如，它会处理标记被错误地放置在代码块声明行之前，或者出现连续重复标记等情况。
*   **使用方法**：
    1.  进入需要处理的 Markdown 文件所在的目录。
    2.  在该目录下执行脚本：`bash cleanup_tags.sh`。

### 3. `d2lbook_MacOS字体安装.sh` - macOS 字体安装脚本

*   **用途**：在 macOS 系统上执行 `d2lbook build pdf` 和 `d2lbook build html` 命令时，需要特定的字体以确保文档正确渲染。此脚本提供了一种便捷的方式来下载和安装这些必需的字体。
*   **使用方法**：
    1.  在终端中直接运行脚本：`bash d2lbook_MacOS字体安装.sh`。
    2.  脚本会自动下载字体文件并将其安装到 `~/Library/Fonts/` 目录下。

### 4. `d2lbook依赖安装及构建流程_250331.md` - d2lbook 开发环境配置指南

*   **用途**：该 Markdown 文档详细介绍了配置 `d2lbook` 开发环境所需的依赖项和完整构建流程。它包括了 `pandoc`, `librsvg`, `latexmk` (MacTeX) 等工具的安装步骤，以及在 Jupyter Notebook 中可能遇到的环境路径问题的解决方案。此外，文档还阐述了 `config.ini` 的配置、构建 `eval` 目录、激活 Tab、构建 HTML 的完整步骤，并提出了优化工作流的建议，例如如何正确处理项目根目录下的 `d2l` 包与 `site-packages` 中包的关系。
*   **阅读建议**：在开始 `d2lbook` 相关开发或构建工作前，请仔细阅读此文档，以确保环境配置正确，并了解推荐的工作流程。

## 如何贡献

欢迎通过提交 Pull Requests 或 Issues 来改进这些工具和文档。