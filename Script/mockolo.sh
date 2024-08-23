targets=()

for target in ${targets[@]}; do
    generated_folder="Package/Sources/${target}/Generated"

	if [ ! -d "$generated_folder" ]; then
		mkdir -p "$generated_folder"
	fi

    mint run mockolo mockolo --sourcedirs Package/Sources/$target \
		--destination Package/Sources/${target}/Generated/${target}Mock.swift \
		--mock-final \
		--macro "DEBUG"
done