targets=(
    "Sample"
)

for target in ${targets[@]}; do
    mint run mockolo mockolo --sourcedirs Package/Sources/$target \
		--destination Package/Sources/AppMock/Generated/${target}MockResults.swift \
		--testable-imports $target \
		--mock-final \
		--macro "DEBUG"
done