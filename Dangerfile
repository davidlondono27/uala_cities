require 'json'

## MR checks --------------------------------------

# Warn when there is a big MR

if github.pr_json["changed_files"].nil?
    warn("Big Merge request (#{git.lines_of_code} lines changed)") if git.lines_of_code > 500
else
    changes_number = github.pr_json["changed_files"]
    if changes_number > 20
        warn("Big Merge request (#{changes_number} changes)")
    end
end

warn "Pull Request is classed as Work in Progress" if github.pr_title.include? "Draft"

has_labels = github.pr_labels != nil
fail("This MR does not refer to an existing label") unless has_labels

# Check for renamed files
if !git.renamed_files.empty?
  warn("File names and locations modified. Keep it in mind on a rebase.")
end

## Main variables --------------------------------------

module_name = "CencoPay-Stage"
xcresult_path = "./build/reports/tests/#{module_name}/#{module_name}.xcresult"

## Tests report --------------------------------------

if File.directory?(xcresult_path)
  # Ignore pods files
  xcode_summary.ignored_files = './SourcePackages/**'

  xcode_summary.ignored_results { |result|
    result.message.start_with? 'ld' # Ignore ld_warnings
  }
  xcode_summary.ignores_warnings = true
  xcode_summary.report(xcresult_path)
else
  fail("xcresult file #{xcresult_path} not found")
end

## Coverage --------------------------------------

xcov_report_path = "./build/reports/coverage/html/#{module_name}/report.json"
check_icon = ":white_check_mark:"
cross_icon = ":x:"
minimum_coverage_percentage = 70.0

if File.exists?(xcov_report_path)
  raw_data = File.read(xcov_report_path)
  coverage_hash = JSON.parse(raw_data)
  coverage_markdown = "## Coverage Status\n"
  coverage_markdown += "|Module name|Coverage|Status|\n"
  coverage_markdown += "|-----------|--------|------|\n"

  for target in coverage_hash['targets']
      module_name = target['name']
      module_coverage = target['coverage'] * 100
      module_status = module_coverage > minimum_coverage_percentage ? check_icon : cross_icon
      coverage_markdown += "|#{module_name}|#{module_coverage.round(2)}|#{module_status}|\n"
  end

  total_coverage = coverage_hash['coverage'] * 100
  total_coverage_status = total_coverage > minimum_coverage_percentage ? check_icon : cross_icon
  coverage_markdown += "|**Total coverage**|**#{total_coverage.round(2)}**|#{total_coverage_status}|\n"
  markdown(coverage_markdown)
else
  fail("Coverage file #{xcov_report_path} not found")
end

## SwiftLint --------------------------------------

swiftlint.config_file = '.swiftlint.yml'
swiftlint.lint_all_files = false
swiftlint.lint_files(fail_on_error: false)